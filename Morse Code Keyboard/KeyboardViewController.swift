//
//  KeyboardViewController.swift
//  Morse Code Keyboard
//
//  Created by Petr Zvoníček on 14.06.14.
//  Copyright (c) 2014 Petr Zvoníček. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton

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
        
        let dashButton = KeyButton.buttonWithType(.Custom) as KeyButton
        dashButton.setTitle("–", forState:.Normal)

        let spaceButton = KeyButton.buttonWithType(.Custom) as KeyButton
        spaceButton.setTitle("Space", forState:.Normal)
        
        // constraints for dotButton
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: 0.0))
        
        // constrains for dashButton
        self.view.addConstraint(NSLayoutConstraint(item: dashButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: dashButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: dashButton, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: 0.0))

        // constrains for dotButton - dashButton
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Width, relatedBy: .Equal, toItem: dashButton, attribute: .Width, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: dotButton, attribute: .Right, relatedBy: .Equal, toItem: dashButton, attribute: .Left, multiplier: 1.0, constant: -12.0))
        
        // constrains for spaceButton
        self.view.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 10.0))
        self.view.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -10.0))
        self.view.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -30.0))
        self.view.addConstraint(NSLayoutConstraint(item: spaceButton, attribute: .Top, relatedBy: .Equal, toItem: dotButton, attribute: .Bottom, multiplier: 1.0, constant: 10.0))
        
        
        self.view.addSubview(dotButton)
        self.view.addSubview(dashButton)
        self.view.addSubview(spaceButton)
        
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("AA Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
