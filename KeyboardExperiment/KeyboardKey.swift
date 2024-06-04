//
//  KeyboardKey.swift
//  KeyboardExperiment
//
//  Created by Park Seongheon on 6/2/24.
//

import SwiftUI

enum Direction {
    case up, down, left, right, none, upLeft, upRight, downLeft, downRight
}

struct KeyboardKey: View {
    let character = "ㅁ"
    @State private var isPressed = false
    
    @State private var currentDirection: Direction = .none
    @State private var previousDirection: Direction = .none
    
    @State private var directions: [Direction] = []
    
    @State private var composedCharacter = ""
    @State private var currentJungsung: Int? = nil
    
    @ObservedObject var automata: Automata
    
    var body: some View {
        Text(isPressed ? "" : character)
            .frame(width: 50, height: 40)
            .background(Color.white)
            .cornerRadius(6)
            .shadow(radius: 0.4, x: 0, y: 1)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { g in
                        isPressed = true
                        
                        if g.translation.width > 20, g.translation.height > 20 {
                            currentDirection = .downRight
                        } else if g.translation.width > 20, g.translation.height < -20 {
                            currentDirection = .upRight
                        } else if g.translation.width < -20, g.translation.height > 20 {
                            currentDirection = .downLeft
                        } else if g.translation.width < -20, g.translation.height < -20 {
                            currentDirection = .upLeft
                        } else if g.translation.width > 30 {
                            currentDirection = .right
                        } else if g.translation.width < -30 {
                            currentDirection = .left
                        } else if g.translation.height > 30 {
                            currentDirection = .down
                        } else if g.translation.height < -30 {
                            currentDirection = .up
                        } else {
                            currentDirection = .none
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                        currentDirection = .none
                        
                        automata.input(consonent: character, syllable: currentJungsung)
                        
                        directions = []
                        composedCharacter = "ㅁ"
                        currentJungsung = nil
                    }
            )
            .onChange(of: currentDirection) {
                if directions.isEmpty && $0 == .none {
                    directions = []
                } else {
                    directions.append($0)
                }
                
                let jungCode: Int? = jungsungCodeByDirection()
                
                if let jungCode {
                    if jungCode != 100 {
                        let composedCode = 0xAC00 + (6 * 588) + (jungCode * 28)
                        let unicode = UnicodeScalar(composedCode)
                        composedCharacter = "\(unicode!)"
                        currentJungsung = jungsungCodeByDirection()
                    }
                } else {
//                    composedCharacter = "ㅁ"
                }
                
                previousDirection = $0
            }
            .background {
                if isPressed {
                    pressedView()
                        .offset(y: -36)
                }
            }
        
            .padding()
            .background(Color(uiColor: #colorLiteral(red: 210/255, green: 212/255, blue: 217/255, alpha: 1)))
            .task {
                composedCharacter = character
            }
    }
    
    func jungsungCodeByDirection() -> Int? {
        switch directions {
        case [.up]:
            return 8
        case [.up, .none]:
            return 11
        case [.up, .none, .up]:
            return 12
        case [.up, .upRight]:
            return 9
        case [.up, .upRight, .up], [.up, .upRight, .none]:
            return 10
        case [.right]:
            return 0
        case [.right, .none]:
            return 1
        case [.right, .none, .right]:
            return 2
        case [.right, .none, .right, .none]:
            return 3
        case [.left]:
            return 4
        case [.left, .none]:
            return 5
        case [.left, .none, .left]:
            return 6
        case [.left, .none, .left, .none]:
            return 7
        case [.down]:
            return 13
        case [.down, .none]:
            return 16
        case [.down, .none, .down]:
            return 17
        case [.down, .downLeft]:
            return 14
        case [.down, .downLeft, .down], [.down, .downLeft, .none]:
            return 15
        case [.upRight], [.upLeft]:
            return 20
        case [.downRight], [.downLeft]:
            return 18
        case [.downRight, .none], [.downLeft, .none]:
            return 19
        case []:
            return nil
        default:
            return 100 // ignore
        }
    }
    
    func jungsungSparseByDirection() -> String? {
        switch directions {
        case [.up]:
            return "ㅗ"
        case [.up, .none]:
            return "ㅚ"
        case [.up, .none, .up]:
            return "ㅛ"
        case [.up, .upRight]:
            return "ㅘ"
        case [.up, .upRight, .up], [.up, .upRight, .none]:
            return "ㅙ"
        case [.right]:
            return "ㅏ"
        case [.right, .none]:
            return "ㅐ"
        case [.right, .none, .right]:
            return "ㅑ"
        case [.right, .none, .right, .none]:
            return "ㅒ"
        case [.left]:
            return "ㅓ"
        case [.left, .none]:
            return "ㅔ"
        case [.left, .none, .left]:
            return "ㅕ"
        case [.left, .none, .left, .none]:
            return "ㅖ"
        case [.down]:
            return "ㅜ"
        case [.down, .none]:
            return "ㅟ"
        case [.down, .none, .down]:
            return "ㅠ"
        case [.down, .downLeft]:
            return "ㅝ"
        case [.down, .downLeft, .down], [.down, .downLeft, .none]:
            return "ㅞ"
        case [.upRight], [.upLeft]:
            return "ㅣ"
        case [.downRight], [.downLeft]:
            return "ㅡ"
        case [.downRight, .none], [.downLeft, .none]:
            return "ㅤ\u{3162}"
        case []:
            return nil
        default:
            return nil
        }
    }
    
    func pressedView() -> some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 10))
            path.addQuadCurve(to: CGPoint(x: 10, y: 0), control: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 60, y: 0))
            path.addQuadCurve(to: CGPoint(x: 70, y: 10), control: CGPoint(x: 70, y: 0))
            path.addRect(CGRect(x: 0, y: 10, width: 70, height: 42))
            
            path.move(to: CGPoint(x: 0, y: 52))
            path.addCurve(to: CGPoint(x: 10, y: 76), control1: CGPoint(x: 0, y: 64), control2: CGPoint(x: 10, y: 67))
            path.addLine(to: CGPoint(x: 60, y: 76))
            path.addCurve(to: CGPoint(x: 70, y: 52), control1: CGPoint(x: 60, y: 67), control2: CGPoint(x: 70, y: 64))
        }
        .foregroundStyle(.white)
        .shadow(radius: 4)
        .frame(width: 70, height: 110)
        .overlay {
            Text(composedCharacter)
                .font(.title)
                .padding(.bottom, 40)
        }
    }
}

//#Preview {
//    KeyboardKey()
//}
