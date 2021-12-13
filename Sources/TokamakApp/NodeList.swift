import TokamakShim

import CoreFoundation
import Foundation

class NodeList: ObservableObject {
    @Published var nodes: [Node] = []
    @Published var wireList = WireList()

    init() {
        let node1 = Node(name: "Node 1", position: CGPoint(x: -200, y: 0), size:CGSize(width: 150, height: 200))
        let node2 = Node(name: "Node 2", position: CGPoint(x:  200, y: 0), size:CGSize(width: 150, height: 200))
        let node3 = Node(name: "Node 3", position: CGPoint(x:  400, y: 100), size:CGSize(width: 150, height: 200))

        wireList.addWire(outputPin: node1.outputPins[0], inputPin: node2.inputPins[0])
//        wireList.addWire(outputPin: node1.outputPins[1], inputPin: node2.inputPins[1])

        nodes.append(node1)
        nodes.append(node2)
        nodes.append(node3)
    }
    
    func locationIsNearPin(location: CGPoint) -> Pin? {
        for node in nodes {
            for pin in node.inputPins {
                let delta = CGPoint(x: pin.getPosition().x - location.x, y: pin.getPosition().y - location.y)
                if abs(delta.x) < 10 && abs(delta.y) < 10 {
                    return pin
                }
            }
        }
        return nil
    }
    
}
