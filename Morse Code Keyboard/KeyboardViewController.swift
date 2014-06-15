//
//  KeyboardViewController.swift
//  Morse Code Keyboard
//
//  Created by Petr Zvoníček on 14.06.14.
//  Copyright (c) 2014 Petr Zvoníček. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var currentWord = ""
    var capsLock = true
    let converter = MorseConverter()
    var typedProxy: UITextDocumentProxy {
        return textDocumentProxy as UITextDocumentProxy
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let dotButton = KeyButton.buttonWithType(.Custom) as KeyButton
        dotButton.setTitle("•", forState:.Normal)
        dotButton.addTarget(self, action: "dotButtonTouched", forControlEvents: .TouchUpInside)
        
        let dashButton = KeyButton.buttonWithType(.Custom) as KeyButton
        dashButton.setTitle("—", forState:.Normal)
        dashButton.addTarget(self, action: "dashButtonTouched", forControlEvents: .TouchUpInside)
        
        let nextKeyboardButton = KeyButton.buttonWithType(.Custom) as KeyButton
        nextKeyboardButton.setTitle("🌐", forState:.Normal)
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        let nextWordButton = KeyButton.buttonWithType(.Custom) as KeyButton
        nextWordButton.setTitle("⏎", forState:.Normal)
        nextWordButton.addTarget(self, action: "nextWordButtonTouched", forControlEvents: .TouchUpInside)

        let spaceButton = KeyButton.buttonWithType(.Custom) as KeyButton
        spaceButton.setTitle("␣", forState:.Normal)
        spaceButton.addTarget(self, action: "spaceButtonTouched", forControlEvents: .TouchUpInside)

        let delButton = KeyButton.buttonWithType(.Custom) as KeyButton
        delButton.setTitle("⌫", forState:.Normal)
        delButton.addTarget(self, action: "deleteButtonTouched", forControlEvents: .TouchUpInside)
        
        let shiftButton = KeyButton.buttonWithType(.Custom) as KeyButton
        shiftButton.setTitle("⇪", forState:.Normal)
        shiftButton.pressed = capsLock
        shiftButton.highlighted = false
        shiftButton.addTarget(self, action: "shiftButtonTouched:", forControlEvents: .TouchUpInside)

        // constraints for dotButton
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.3, constant: 0.0))
        
        // constraints for dashButton
        self.view.addConstraint(NSLayoutConstraint(item: dashButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: dashButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: dashButton, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.3, constant: 0.0))

        // constraints for dotButton - dashButton
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Width, relatedBy: .Equal, toItem: dashButton, attribute: .Width, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Right, relatedBy: .Equal, toItem: dashButton, attribute: .Left, multiplier: 1.0, constant: -12.0))
        
        // constraints for spaceButton
        self.view.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.3, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .Top, relatedBy: .Equal, toItem: dotButton, attribute: .Bottom, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .Left, relatedBy: .Equal, toItem: dotButton, attribute: .Left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .Width, relatedBy: .Equal, toItem: dotButton, attribute: .Width, multiplier: 1.0, constant: 0.0))
        
        // constraints for nextWordButton
        self.view.addConstraint(NSLayoutConstraint(item: nextWordButton, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.3, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: nextWordButton, attribute: .Top, relatedBy: .Equal, toItem: dashButton, attribute: .Bottom, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: nextWordButton, attribute: .Left, relatedBy: .Equal, toItem: dashButton, attribute: .Left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: nextWordButton, attribute: .Width, relatedBy: .Equal, toItem: dashButton, attribute: .Width, multiplier: 1.0, constant: 0.0))

        // constraints for nextKeyboardButton
        self.view.addConstraint(NSLayoutConstraint(item: nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 0.35, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: nextKeyboardButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 0.65, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: nextKeyboardButton, attribute: .Top, relatedBy: .Equal, toItem: nextWordButton, attribute: .Bottom, multiplier: 1.0, constant: 10.0))

        // constraints for delButton
        self.view.addConstraint(NSLayoutConstraint(item: delButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: delButton, attribute: .Left, relatedBy: .Equal, toItem: nextKeyboardButton, attribute: .Right, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: delButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: delButton, attribute: .Top, relatedBy: .Equal, toItem: nextWordButton, attribute: .Bottom, multiplier: 1.0, constant: 10.0))
        
        // constraints for delButton
        self.view.addConstraint(NSLayoutConstraint(item: shiftButton, attribute: .Right, relatedBy: .Equal, toItem: nextKeyboardButton, attribute: .Left, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: shiftButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: shiftButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: shiftButton, attribute: .Top, relatedBy: .Equal, toItem: nextWordButton, attribute: .Bottom, multiplier: 1.0, constant: 10.0))
        
        
        self.view.addSubview(dotButton)
        self.view.addSubview(dashButton)
        self.view.addSubview(spaceButton)
        self.view.addSubview(nextWordButton)
        self.view.addSubview(nextKeyboardButton)
        self.view.addSubview(delButton)
        self.view.addSubview(shiftButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func textWillChange(textInput: UITextInput) {
    }

    override func textDidChange(textInput: UITextInput) {
    }

    func dotButtonTouched() {
        currentWord += "·"
    }
    
    func dashButtonTouched() {
        currentWord += "−"
    }
    
    func nextWordButtonTouched() {
        if let letter = self.converter.getCharacterForCode(currentWord) {
            if letter == "*" {
                if let context = typedProxy.documentContextBeforeInput {
                    for i in 1..countElements(context) {
                        typedProxy.deleteBackward()
                    }
                }
            } else {
                var append = (capsLock ? String(letter) : String(letter).lowercaseString)
                typedProxy.insertText(append)
            }
        }
        currentWord = ""
    }
    
    func spaceButtonTouched() {
        typedProxy.insertText(" ")
    }
    
    func deleteButtonTouched() {
        typedProxy.deleteBackward()
    }
    
    func shiftButtonTouched(sender: KeyButton!) {
        capsLock = !capsLock
        sender.pressed = capsLock
    }
}
