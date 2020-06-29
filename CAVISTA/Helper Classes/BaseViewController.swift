//
//  BaseViewController.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 27/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import UIKit
import JGProgressHUD
import DropDown

/// Base Class for All controllers and use to add common method of Controller
class BaseViewController: UIViewController {

    let hud = JGProgressHUD(style: .extraLight)
    let selectionListDropDown = DropDown()
    
    /// Show Activity Indicator
    /// - Parameter msg: message string
    func showProgress(msg:String) {
        
        hud.textLabel.text = msg
        hud.show(in: self.view)
    }
    
    /// Hide Activity Indicator
    func stopProgress() {
        
        hud.dismiss()
    }
    
    /// Show Dropdown
    /// - Parameters:
    ///   - anchorView: Dropdown need to below view
    ///   - data: data to show on dropdown
    func showSelectionListDropdown(anchorView:UIView, data:[String]) {
        
        self.selectionListDropDown.anchorView = anchorView
        self.selectionListDropDown.bottomOffset = CGPoint(x: 0, y: anchorView.bounds.height)
        self.selectionListDropDown.dataSource = data
        self.selectionListDropDown.backgroundColor = UIColor.white
        self.selectionListDropDown.cornerRadius = 5
        self.selectionListDropDown.show()
    }
    
    /// Hide dropdown
    func hideDropdown() {
        
        self.selectionListDropDown.hide()
    }
}
