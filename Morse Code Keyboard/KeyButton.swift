//
//  KeyButton.swift
//  SwiftMorseCodeKeyboard
//
//  Created by Petr Zvoníček on 14.06.14.
//  Copyright (c) 2014 Petr Zvoníček. All rights reserved.
//


import UIKit

class KeyButton: UIButton {

    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        self.setTitleColor(UIColor.blackColor(), forState:.Normal)
        self.setTitleColor(UIColor.whiteColor(), forState:.Highlighted)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.highlighted = false
    }

    override var highlighted: Bool {
    didSet {
        if (highlighted) {
            self.backgroundColor = UIColor.grayColor()
        } else {
            self.backgroundColor = UIColor.whiteColor()
        }
    }
    }

}
