import TokamakShim

import CoreFoundation
import Foundation

struct PinView: View {
    
    @EnvironmentObject var pin: Pin
    @EnvironmentObject var nodeList: NodeList
    
    @State private var dragging = false
    
    let pinSize = CGSize(width: 20, height: 20)
    
    let hotColor = Color.orange
    
    let pinColors = [
        "string" : Color.white,
        "bool" : Color.green
    ]
        
    @ViewBuilder public var body: some View {
        
        Rectangle()
            .fill(pin.hot ? hotColor : pinColors[pin.type]!)
            .frame(width: pinSize.width, height: pinSize.height, alignment: .center)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if !dragging {
                            dragging = true
                            nodeList.wireList.addWire(outputPin: pin, inputPin: nil)
                            nodeList.wireList.draggedWirePosition = gesture.location
                        }
                        if nodeList.wireList.draggedWire != nil {
                            let pinLocation = pin.getPosition()
                            nodeList.wireList.draggedWirePosition = CGPoint(x: gesture.location.x + pinLocation.x - pinSize.width / 2,
                                                                            y: gesture.location.y + pinLocation.y - pinSize.height / 2)
                        
                            if let draggedWirePosition = nodeList.wireList.draggedWirePosition {
                                if let otherPin = nodeList.locationIsNearPin(location: draggedWirePosition) {
                                    nodeList.wireList.draggedWirePosition = otherPin.getPosition()
                                }
                            }

                        }
                                                
                    }
                    .onEnded { _ in
                        dragging = false
                        if let draggedWirePosition = nodeList.wireList.draggedWirePosition {
                            if let otherPin = nodeList.locationIsNearPin(location: draggedWirePosition) {
                                nodeList.wireList.connect(otherPin: otherPin)
                                return
                            }
                        }
                        nodeList.wireList.draggedWire = nil
                    }
            )
//            .onHover { hover in
//                if hover {
//                    if let draggedWire = nodeList.wireList.draggedWire {
//                        pin.hot = nodeList.wireList.canConnect(otherPin: pin)
//                    }
//                } else {
//                    pin.hot = false
//                }
//            }
    }
}
