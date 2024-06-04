//
//  KeyboardOverlay.swift
//  KeyboardExperiment
//
//  Created by Park Seongheon on 6/2/24.
//

import SwiftUI

struct KeyboardOverlay: View {
    let character: String

    var body: some View {
        ZStack(alignment: .bottom) {
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
                Text(character)
                    .font(.title)
                    .padding(.bottom, 40)
            }
            Text(character)
                .frame(width: 50, height: 40)
                .background(Color.white)
                .cornerRadius(6)
                .shadow(radius: 0.4, x: 0, y: 1)
        }
        .padding()
        .background(Color(uiColor: #colorLiteral(red: 210/255, green: 212/255, blue: 217/255, alpha: 1)))
    }
}

#Preview {
    KeyboardOverlay(character: "ㅁ")
}
