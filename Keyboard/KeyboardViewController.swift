//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Park Seongheon on 5/24/24.
//

import Combine
import os.log
import SwiftUI
import UIKit

private var proxy: UITextDocumentProxy!

class KeyboardViewController: UIInputViewController {
                var automata: Automata!
    
    @IBOutlet   var nextKeyboardButton: UIButton!
    
    @IBOutlet   var firstRowStack:      UIStackView!
    @IBOutlet   var secondRowStack:     UIStackView!
    @IBOutlet   var thirdRowStack:      UIStackView!
    @IBOutlet   var fourthRowStack:     UIStackView!
    @IBOutlet   var fifthRowStack:      UIStackView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
        self.setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        os_log("viewDidLoad")
        
        proxy = textDocumentProxy as UITextDocumentProxy
        
        automata = Automata(proxy: proxy)
        
        // Perform custom UI setup here
        self.configureNextKeyboardButton()
//        self.configureUI()
//        self.setupLayout()
        
        let testButton = UIHostingController(rootView: KeyboardKey(automata: automata))
        
        self.view.addSubview(testButton.view)
        
        testButton.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        
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
    
    func configureNextKeyboardButton() {
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    }
    
    func configureUI() {
        self.firstRowStack  = {
            let s = UIStackView()
            
            s.axis = .horizontal
            s.backgroundColor = .red
            
            return s
        }()
        self.secondRowStack = {
            let s = UIStackView()
            
            s.axis = .horizontal
            s.backgroundColor = .green
            
            return s
        }()
        self.thirdRowStack  = {
            let s = UIStackView()
            
            s.axis = .horizontal
            s.backgroundColor = .blue
            
            return s
        }()
        self.fourthRowStack = {
            let s = UIStackView()
            
            s.axis = .horizontal
            s.backgroundColor = .yellow
            
            return s
        }()
        self.fifthRowStack  = {
            let s = UIStackView()
            
            s.axis = .horizontal
            s.backgroundColor = .purple
            
            return s
        }()
        
//        rootStack.addArrangedSubview(firstRowStack)
//        rootStack.addArrangedSubview(secondRowStack)
//        rootStack.addArrangedSubview(thirdRowStack)
//        rootStack.addArrangedSubview(fourthRowStack)
//        rootStack.addArrangedSubview(fifthRowStack)
        
//        self.fourthRowStack.addArrangedSubview(self.nextKeyboardButton)
        
//        self.view.addSubview(self.firstRowStack)
//        self.view.addSubview(self.secondRowStack)
//        self.view.addSubview(self.thirdRowStack)
//        self.view.addSubview(self.fourthRowStack)
//        self.view.addSubview(self.fifthRowStack)
        
//        NSLayoutConstraint.activate([
//            rootStack.heightAnchor.constraint(equalToConstant: 216.0)
//        ])
    }
    
    @objc func testButtonTapped() {
        os_log("testButtonTapped")
//        proxy.insertText("ᅡ")
        proxy.deleteBackward()
        proxy.insertText("ㅂ")
        print(proxy.selectedText)
    }
    
    func setupLayout() {
//        NSLayoutConstraint.activate([
//            self.firstRowStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            self.firstRowStack.topAnchor.constraint(equalTo: self.view.topAnchor),
//            self.firstRowStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            self.firstRowStack.heightAnchor.constraint(equalToConstant: 54.0),
//
//            self.secondRowStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            self.secondRowStack.topAnchor.constraint(equalTo: self.firstRowStack.bottomAnchor),
//            self.secondRowStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            self.secondRowStack.heightAnchor.constraint(equalToConstant: 54.0),
//
//            self.thirdRowStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            self.thirdRowStack.topAnchor.constraint(equalTo: self.secondRowStack.bottomAnchor),
//            self.thirdRowStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            self.thirdRowStack.heightAnchor.constraint(equalToConstant: 54.0),
//
//            self.fourthRowStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            self.fourthRowStack.topAnchor.constraint(equalTo: self.thirdRowStack.bottomAnchor),
//            self.fourthRowStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            self.fourthRowStack.heightAnchor.constraint(equalToConstant: 54.0),
////            self.fourthRowStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//
//            self.fifthRowStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            self.fifthRowStack.topAnchor.constraint(equalTo: self.fourthRowStack.bottomAnchor),
//            self.fifthRowStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            self.fifthRowStack.heightAnchor.constraint(equalToConstant: 54.0),
//            self.fifthRowStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        ])
    }
}
