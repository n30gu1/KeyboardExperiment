//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Park Seongheon on 5/24/24.
//

import SwiftUI

struct KeyboardView: View {
    @ObservedObject var state: KeyboardState
    var nextKeyboardButton: NextKeyboardButtonRepresentable
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            nextKeyboardButton
        }
            .frame(height: 216)
    }
}
