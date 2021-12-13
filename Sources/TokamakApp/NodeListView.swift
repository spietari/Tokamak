import TokamakShim

import CoreFoundation
import Foundation

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
  private var content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  func makeUIView(context: Context) -> UIScrollView {
    // set up the UIScrollView
    let scrollView = UIScrollView()
    scrollView.delegate = context.coordinator  // for viewForZooming(in:)
    scrollView.maximumZoomScale = 20
      scrollView.minimumZoomScale = 0.1
    scrollView.bouncesZoom = true
      scrollView.backgroundColor = UIColor.orange

    // create a UIHostingController to hold our SwiftUI content
    let hostedView = context.coordinator.hostingController.view!
    hostedView.translatesAutoresizingMaskIntoConstraints = true
    hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    hostedView.frame = scrollView.bounds
      hostedView.backgroundColor = UIColor.green
    scrollView.addSubview(hostedView)

    return scrollView
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(hostingController: UIHostingController(rootView: self.content))
  }

  func updateUIView(_ uiView: UIScrollView, context: Context) {
    // update the hosting controller's SwiftUI content
    context.coordinator.hostingController.rootView = self.content
    assert(context.coordinator.hostingController.view.superview == uiView)
  }

  // MARK: - Coordinator

  class Coordinator: NSObject, UIScrollViewDelegate {
    var hostingController: UIHostingController<Content>

    init(hostingController: UIHostingController<Content>) {
      self.hostingController = hostingController
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return hostingController.view
    }
  }
}

struct NodeListView: View {
    
    @EnvironmentObject var nodeList: NodeList
    
    var body: some View {
        GeometryReader { geometry in
            ZoomableScrollView {
                ZStack {
                    ZStack {
                        ForEach(nodeList.nodes) { node in
                            NodeView().environmentObject(node).environmentObject(nodeList).environmentObject(nodeList.wireList)
                        }
                    }
                    WireListView().environmentObject(nodeList.wireList)
                }
            }
            .frame(width: 10*geometry.size.width, height: 10*geometry.size.height, alignment: .center)
//            .background(Color.blue)
            .onAppear {
                // HACK
                nodeList.wireList.screenSize = CGSize(width: 10*geometry.size.width, height: 10*geometry.size.height)
            }
            .gesture(
                TapGesture()
                    .onEnded {
                        let node = Node(name: "New Node", position: CGPoint.zero, size:CGSize(width: 150, height: 200))
                        nodeList.nodes.append(node)
                }
            )
        }
    }
}
