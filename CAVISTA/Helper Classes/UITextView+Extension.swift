//
//  UITextView+Extension.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 28/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import UIKit

// Common extension of UITextView
extension UITextView {
    
    /// Set Content, Font, Color
    /// - Parameters:
    ///   - fontSize: font size
    ///   - FontName: font name
    ///   - textColor: text color
    func setContentForTextView(fontSize:String, FontName:String, textColor:UIColor) {
        
        self.font = DynamicFont.shared.getSpecificFont(size: fontSize, fontName: FontName)
        self.textColor = textColor
    }
}
