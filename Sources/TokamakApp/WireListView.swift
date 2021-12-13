import TokamakShim

import CoreFoundation
import Foundation

struct WireListView: View {
    
    @EnvironmentObject var wireList: WireList

    @ViewBuilder public var body: some View {
        ZStack {
            Path { path in
                path.move(   to: CGPoint(x: 0,                  y: 0))
                path.addLine(to: CGPoint(x: wireList.screenSize.width,    y: 0))
                path.addLine(to: CGPoint(x: wireList.screenSize.width,    y: wireList.screenSize.height))
                path.addLine(to: CGPoint(x: 0,                  y: wireList.screenSize.height))
                path.addLine(to: CGPoint(x: 0,                  y: 0))

                for wire in wireList.wires {
                    if let inputPin = wire.inputPin {
                        if let outputPin = wire.outputPin {
                            let  inputCenter = CGPoint(x: wireList.screenSize.width / 2 + inputPin.getPosition().x , y: wireList.screenSize.height / 2 + inputPin.getPosition().y)
                            let outputCenter = CGPoint(x: wireList.screenSize.width / 2 + outputPin.getPosition().x, y: wireList.screenSize.height / 2 + outputPin.getPosition().y)
                            path.move(   to: outputCenter)
//                            path.addLine(to: outputCenter)
                            path.addCurve(to: inputCenter,
                                          control1: CGPoint(x: (0.25 * outputCenter.x + 0.75 * inputCenter.x), y: outputCenter.y),
                                          control2: CGPoint(x: (0.75 * outputCenter.x + 0.25 * inputCenter.x), y: inputCenter.y))
                        }
                    }
                }
                
                if let draggedWire = wireList.draggedWire {
                    var inputCenter: CGPoint?
                    if let inputPin = draggedWire.inputPin {
                        inputCenter = CGPoint(x: wireList.screenSize.width / 2 + inputPin.getPosition().x , y: wireList.screenSize.height / 2 + inputPin.getPosition().y)
                    } else {
                        if let draggedWirePosition = wireList.draggedWirePosition {
                            inputCenter = CGPoint(x: draggedWirePosition.x + wireList.screenSize.width / 2, y: draggedWirePosition.y + wireList.screenSize.height / 2)
                        }
                    }
                    var outputCenter: CGPoint?
                    if let outputPin = draggedWire.outputPin {
                        outputCenter = CGPoint(x: wireList.screenSize.width / 2 + outputPin.getPosition().x , y: wireList.screenSize.height / 2 + outputPin.getPosition().y)
                    } else {
                        if let draggedWirePosition = wireList.draggedWirePosition {
                            outputCenter = CGPoint(x: draggedWirePosition.x + wireList.screenSize.width / 2, y: draggedWirePosition.y + wireList.screenSize.height / 2)
                        }
                    }
                    if let inputCenter = inputCenter, let outputCenter = outputCenter {
                        path.move(   to: inputCenter)
                        path.addLine(to: outputCenter)
                    }
                }
                
            }.stroke(Color(red: 1, green: 0, blue: 1, opacity: 1), lineWidth: 4)
        }
    }
}
