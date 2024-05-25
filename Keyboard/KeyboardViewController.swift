//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Park Seongheon on 5/24/24.
//

import Combine
import SwiftUI
import UIKit
import os.log

class KeyboardViewController: UIInputViewController {
    var state = KeyboardState()
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        os_log("viewDidLoad")
        
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
        
        nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    }
    
    func configureUI() {
        let rootStackView = UIStackView()
        
        rootStackView.axis = .vertical
        rootStackView.alignment = .fill
        rootStackView.distribution = .fill
        
        let firstRowStackView = UIStackView()
        let secondRowStackView = UIStackView()
        let thirdRowStackView = UIStackView()
        let fourthRowStackView = UIStackView()
        
        rootStackView.addArrangedSubview(firstRowStackView)
        rootStackView.addArrangedSubview(secondRowStackView)
        rootStackView.addArrangedSubview(thirdRowStackView)
        rootStackView.addArrangedSubview(fourthRowStackView)
        
        firstRowStackView.axis = .horizontal
        secondRowStackView.axis = .horizontal
        thirdRowStackView.axis = .horizontal
        fourthRowStackView.axis = .horizontal
        
        fourthRowStackView.addArrangedSubview(nextKeyboardButton)
        
        self.view.addSubview(rootStackView)
    }
}
