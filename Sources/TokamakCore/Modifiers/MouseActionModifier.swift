// Copyright 2021 Tokamak contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
/// Underscore is present in the name for SwiftUI compatibility.

import Foundation

public struct _MouseActionModifier: ViewModifier {
    public var moved: ((CGPoint) -> ())?
    public var clicked: ((Int, Bool, CGPoint) -> ())?
    public typealias Body = Never
}

extension ModifiedContent
  where Content: View, Modifier == _MouseActionModifier
{
    var position: ((CGPoint) -> ())? { modifier.moved }
    var clicked: ((Int, Bool, CGPoint) -> ())? { modifier.clicked }
}

public extension View {
  func onMouseMoved(perform action: ((CGPoint) -> ())?) -> some View {
    modifier(_MouseActionModifier(moved: action))
  }
    func onMouseClicked(perform action: ((Int, Bool, CGPoint) -> ())?) -> some View {
      modifier(_MouseActionModifier(clicked: action))
    }
}
