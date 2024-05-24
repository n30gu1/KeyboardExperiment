//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Park Seongheon on 5/24/24.
//

import Combine
import SwiftUI
import UIKit

struct NextKeyboardButtonRepresentable: UIViewRepresentable {
    @ObservedObject var state: KeyboardState
    weak var target: KeyboardViewController!
    let selector: Selector
    
    init(state: KeyboardState, target: KeyboardViewController, selector: Selector) {
        self.state = state
        self.target = target
        self.selector = selector
    }
    
    func makeUIView(context: Context) -> UIButton {
        UIButton(type: .system)
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        uiView.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        uiView.sizeToFit()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        uiView.addTarget(self.target, action: self.selector, for: .allTouchEvents)
        
        self.state.$nextKeyboardButtonIsHidden
            .sink { isHidden in
                uiView.isHidden = isHidden
                
                #if DEBUG
                print(isHidden)
                #endif
            }
            .store(in: &context.coordinator.cancellables)
    }
    
    class Coordinator {
        var cancellables: Set<AnyCancellable> = []
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

class KeyboardViewController: UIInputViewController {
    var state = KeyboardState()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        let nextKeyboardButton = NextKeyboardButtonRepresentable(state: self.state, target: self, selector: #selector(handleInputModeList(from:with:)))
        
        let keyboardViewHosting = UIHostingController(rootView: KeyboardView(state: self.state, nextKeyboardButton: nextKeyboardButton))
        keyboardViewHosting.view.translatesAutoresizingMaskIntoConstraints = false
        keyboardViewHosting.view.backgroundColor = .clear
        self.view.addSubview(keyboardViewHosting.view)
        
        NSLayoutConstraint.activate([
            keyboardViewHosting.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            keyboardViewHosting.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            keyboardViewHosting.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            keyboardViewHosting.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        self.state.nextKeyboardButtonIsHidden = !self.needsInputModeSwitchKey
        
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
}
