//
//  KeyButton.swift
//  SwiftMorseCodeKeyboard
//
//  Created by Petr Zvoníček on 14.06.14.
//  Copyright (c) 2014 Petr Zvoníček. All rights reserved.
//


import UIKit

class KeyButton: UIButton {

    var pressed = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.blackColor(), forState:.Normal)
        self.setTitleColor(UIColor.whiteColor(), forState:.Highlighted)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.highlighted = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var highlighted: Bool {
        didSet {
            if (highlighted) {
                self.backgroundColor = UIColor.grayColor()
            } else {
                if(pressed) {
                    self.backgroundColor = UIColor.lightGrayColor()
                } else {
                    self.backgroundColor = UIColor.whiteColor()
                }
            }
        }
    }

}
