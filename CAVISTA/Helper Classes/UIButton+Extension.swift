//
//  UIButton+Extension.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 28/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import UIKit

// Common extension of UIButton
extension UIButton {
    
    /// Set Content, Font, Color
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: font size
    ///   - FontName: font name
    ///   - textColor: text color
    ///   - backgroundColor: background color
    func setContentForButton(title:String, fontSize:String, FontName:String, textColor:UIColor, backgroundColor:UIColor) {
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = DynamicFont.shared.getSpecificFont(size: fontSize, fontName: FontName)
        self.setTitleColor(textColor, for: .normal)
    }
}
