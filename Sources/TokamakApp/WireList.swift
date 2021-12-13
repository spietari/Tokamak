import TokamakShim

import CoreFoundation
import Foundation

class WireList: ObservableObject {
    @Published var wires = [Wire]()
    
    @Published var draggedWire: Wire?
    @Published var draggedWirePosition: CGPoint?

    @Published var screenSize = CGSize.zero
    
    @Published var refreshPosition = CGPoint.zero
    
    init() {

    }
    
    func addWire(outputPin: Pin?, inputPin: Pin?) {
        let wire = Wire(outputPin: outputPin, inputPin: inputPin)
        if outputPin != nil && inputPin != nil {
            wires.append(wire)
        } else {
            draggedWire = wire
        }
    }
    
    func canConnect(otherPin: Pin) -> Bool {
        if let draggedWire = draggedWire {
            if otherPin.input {
                if let outputPin = draggedWire.outputPin {
                    return outputPin.type == otherPin.type
                }
            } else {
                if let inputPin = draggedWire.inputPin {
                    return inputPin.type == otherPin.type
                }
            }
        }
        return false
    }
    
    func connect(otherPin: Pin) {
        if canConnect(otherPin: otherPin) {
            if let draggedWire = draggedWire {
                if otherPin.input {
                    if draggedWire.outputPin != nil {
                        draggedWire.inputPin = otherPin
                        wires = wires.filter {
                            $0.inputPin !== otherPin
                        }
                        wires.append(draggedWire)
                    }
                } else {
                    if draggedWire.inputPin != nil {
                        draggedWire.outputPin = otherPin
                        wires.append(draggedWire)
                    }
                }
            }
        }
        draggedWire = nil
        draggedWirePosition = nil
        otherPin.hot = false
    }
    
}
