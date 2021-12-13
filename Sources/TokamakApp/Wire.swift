import TokamakShim

import CoreFoundation
import Foundation

class Wire: ObservableObject, Identifiable {

    @Published var inputPin: Pin?
    @Published var outputPin: Pin?
    
    @Published var parentPosition: CGPoint?
    
    init(outputPin: Pin?, inputPin: Pin?) {
        self.outputPin = outputPin
        self.inputPin = inputPin
    }
    
}
