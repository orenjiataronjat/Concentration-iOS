//
//  Themes.swift
//  Concentration
//
//  Created by David Lattimer on 5/15/18.
//  Copyright © 2018 David Lattimer. All rights reserved.
//

import UIKit

struct Theme {
    var themeName = ""
    var emojiChoices = [""]
    var primaryColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var secondaryColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    init(name newThemeName: String, emojis newEmoji: [String], primaryColor newPrimaryColor: UIColor, secondaryColor newSecondaryColor: UIColor){
        self.themeName = newThemeName
        self.emojiChoices = newEmoji
        self.primaryColor = newPrimaryColor
        self.secondaryColor = newSecondaryColor
    }
}
