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

import TokamakCore                                    
import Foundation

extension _MouseActionModifier: DOMActionModifier {
  public var listeners: [String: Listener] {
    [
      "mousemove":
        {                
            pos in 
                if let moved = moved {
                    if let x = pos["clientX"].number {
                        if let y = pos["clientY"].number {
                            moved(CGPoint(x: x, y: y))
                        }
                    }                       
                }
        },       
      "mousedown":
        {
            pos in
                if let clicked = clicked {
                    if let x = pos["clientX"].number {
                        if let y = pos["clientY"].number {
                            if let button = pos["button"].number {
                                clicked(Int(button + 0.5), true, CGPoint(x: x, y: y))
                            }
                        }
                    }
                }
     
        },
      "mouseup":
        {
            pos in
                if let clicked = clicked {
                    if let x = pos["clientX"].number {
                        if let y = pos["clientY"].number {
                            if let button = pos["button"].number {
                                clicked(Int(button + 0.5), false, CGPoint(x: x, y: y))
                            }
                        }
                    }
                }
            
        },
    ]
  }
}
