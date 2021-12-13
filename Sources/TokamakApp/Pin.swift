import TokamakShim

import CoreFoundation
import Foundation

class Pin: ObservableObject, Identifiable {

    @Published var input: Bool = false
    @Published var parentNode: Node
    @Published var hot: Bool = false

    var type: String
    var pinIndex: Int

    init(type: String, input: Bool, parentNode: Node, pinIndex: Int) {
        self.type = type
        self.input = input
        self.parentNode = parentNode
        self.pinIndex = pinIndex
    }
    
    func getPosition() -> CGPoint {
        var p: CGPoint
        if input {
            p = CGPoint(x: parentNode.position.x - parentNode.size.width / 2 + 15, y: parentNode.position.y + 25 * CGFloat(pinIndex) - 12)
        } else {
            p = CGPoint(x: parentNode.position.x + parentNode.size.width / 2 - 15, y: parentNode.position.y + 25 * CGFloat(pinIndex) - 12)
        }
        return p
    }
    
}
