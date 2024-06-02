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
                        print(directions)
                        
                        directions = []
                    }
            )
            .onChange(of: currentDirection) {
                if directions.isEmpty && $0 == .none {
                    directions = []
                } else {
                    directions.append($0)
                }
                
                var jungCode: Int? = nil
                
                switch directions {
                case [.up]:
                    jungCode = 8
                case [.up, .none]:
                    jungCode = 11
                case [.up, .none, .up]:
                    jungCode = 12
                case [.up, .upRight]:
                    jungCode = 9
                case [.up, .upRight, .up], [.up, .upRight, .none]:
                    jungCode = 10
                case [.right]:
                    jungCode = 0
                case [.right, .none]:
                    jungCode = 1
                case [.right, .none, .right]:
                    jungCode = 2
                case [.right, .none, .right, .none]:
                    jungCode = 3
                case [.left]:
                    jungCode = 4
                case [.left, .none]:
                    jungCode = 5
                case [.left, .none, .left]:
                    jungCode = 6
                case [.left, .none, .left, .none]:
                    jungCode = 7
                case [.down]:
                    jungCode = 13
                case [.down, .none]:
                    jungCode = 14
                case [.down, .none, .down]:
                    jungCode = 15
                case [.down, .downLeft]:
                    jungCode = 16
                case [.down, .downLeft, .down], [.down, .downLeft, .none]:
                    jungCode = 17
                case [.upRight], [.upLeft]:
                    jungCode = 18
                case [.downRight], [.downLeft]:
                    jungCode = 19
                case [.downRight, .none], [.downLeft, .none]:
                    jungCode = 20
                case []:
                    composedCharacter = "ㅁ"
                default:
//                    composedCharacter = character
                    break
                }
                
                
                if let jungCode = jungCode {
                    let composedCode = 0xAC00 + (6 * 588) + (jungCode * 28)
                    let unicode = UnicodeScalar(composedCode)
                    composedCharacter = "\(unicode!)"
                } else {
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

#Preview {
    KeyboardKey()
}
