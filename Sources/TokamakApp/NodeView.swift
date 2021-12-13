import TokamakShim

import CoreFoundation
import Foundation
import SwiftUI

struct NodeView: View {
    
    @EnvironmentObject var node: Node
    @EnvironmentObject var wireList: WireList
    
    @State private var dragging = false
    @State private var dragStartOffset = CGPoint.zero
        
    @ViewBuilder public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: node.size.width, height: node.size.height, alignment: .center)
            Text(node.name)
                .offset(x: 0, y: -node.size.height / 2 + 15)
            VStack {
                ForEach(node.inputPins) { inputPin in
                    PinView().environmentObject(inputPin)
                }
            }.offset(x: -node.size.width / 2 + 15, y:0)
            VStack {
                ForEach(node.outputPins) { outputPin in
                    PinView().environmentObject(outputPin)
                }
            }.offset(x: node.size.width / 2 - 15, y:0)
        }
            .offset(x: node.position.x, y: node.position.y)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if !dragging {
                            dragStartOffset = node.position
                            dragging = true
                        }
                        node.position = CGPoint(x: dragStartOffset.x + gesture.translation.width, y: dragStartOffset.y + gesture.translation.height)
                        wireList.refreshPosition = node.position
                    }
                    .onEnded { _ in
                        dragging = false
                    }
            )
    }

}
