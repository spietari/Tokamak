import TokamakShim

import CoreFoundation
import Foundation

class Node: ObservableObject, Identifiable {

    @Published var name: String
    @Published var position: CGPoint
    @Published var size: CGSize
    @Published var mouseDown: Bool
    @Published var inputPins = [Pin]()
    @Published var outputPins = [Pin]()

    var lastPos: CGPoint?
    
    init(name: String, position: CGPoint, size: CGSize) {
        self.name = name
        self.position = position
        self.size = size
        mouseDown = false
        
        inputPins.append(Pin(type: "string", input: true, parentNode: self, pinIndex: 0))
        inputPins.append(Pin(type: "bool",   input: true, parentNode: self, pinIndex: 1))

        outputPins.append(Pin(type: "string", input: false, parentNode: self, pinIndex: 0))
        outputPins.append(Pin(type: "bool",   input: false, parentNode: self, pinIndex: 1))
    }
    
    func updatePosition(point: CGPoint) {
        guard let lastPos = lastPos else {
            lastPos = point
            return
        }
        self.position = CGPoint(x: self.position.x + point.x - lastPos.x, y: self.position.y + point.y - lastPos.y)
        self.lastPos = point
    }
    
    func isInside(point: CGPoint) -> Bool {
        point.x >= self.position.x - self.size.width  / 2 && point.x < self.position.x + self.size.width  / 2 &&
        point.y >= self.position.y - self.size.height / 2 && point.y < self.position.y + self.size.height / 2
    }

}
