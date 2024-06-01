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
                var state = KeyboardState()
    
    @IBOutlet   var nextKeyboardButton: UIButton!
    
    @IBOutlet   var firstRowStack:      UIStackView!
    @IBOutlet   var secondRowStack:     UIStackView!
    @IBOutlet   var thirdRowStack:      UIStackView!
    @IBOutlet   var fourthRowStack:     UIStackView!
    @IBOutlet   var fifthRowStack:      UIStackView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        os_log("viewDidLoad")
        
        proxy = textDocumentProxy as UITextDocumentProxy
        
        // Perform custom UI setup here
        self.configureNextKeyboardButton()
        self.configureUI()
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
            
            return s
        }()
        self.secondRowStack = {
            let s = UIStackView()
            
            s.axis = .horizontal
            
            return s
        }()
        self.thirdRowStack  = {
            let s = UIStackView()
            
            s.axis = .horizontal
            
            return s
        }()
        self.fourthRowStack = {
            let s = UIStackView()
            
            s.axis = .horizontal
            
            return s
        }()
        self.fifthRowStack  = {
            let s = UIStackView()
            
            s.axis = .horizontal
            
            return s
        }()
        
//        rootStack.addArrangedSubview(firstRowStack)
//        rootStack.addArrangedSubview(secondRowStack)
//        rootStack.addArrangedSubview(thirdRowStack)
//        rootStack.addArrangedSubview(fourthRowStack)
//        rootStack.addArrangedSubview(fifthRowStack)
        
        self.fourthRowStack.addArrangedSubview(self.nextKeyboardButton)
        
//        self.view.addSubview(rootStack)
        
//        NSLayoutConstraint.activate([
//            rootStack.heightAnchor.constraint(equalToConstant: 216.0)
//        ])
    }
}
