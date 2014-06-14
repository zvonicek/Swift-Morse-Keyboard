//
//  Model.swift
//  SwiftMorseCodeKeyboard
//
//  Created by Petr Zvoníček on 14.06.14.
//  Copyright (c) 2014 Petr Zvoníček. All rights reserved.
//

import Foundation

class MorseConverter {
    let characters = ["·−" : "A", "−···" : "B", "−·−·" : "C", "−··" : "D", "·" : "E", "··−·" : "F", "−−·" : "G", "····" : "H", "··" : "I", "·−−−" : "J", "−·−" : "K", "·−··" : "L", "−−" : "M", "−·" : "N", "−−−" : "O", "·−−·" : "P", "−−·−" : "Q", "·−·" : "R", "···" : "S", "−" : "T", "··−" : "U", "···−" : "V", "·−−" : "W", "−··−" : "X", "−·−−" : "Y", "−−··" : "Z", "−−−−−" : "0", "·−−−−" : "1", "··−−−" : "2", "···−−" : "3", "····−" : "4", "·····" : "5", "−····" : "6", "−−···" : "7", "−−−··" : "8", "−−−−·" : "9"];
    
    func getCharacterForCode(code: NSString) -> NSString? {
       return characters[code]
    }
    
}