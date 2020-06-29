//
//  InfoViewController.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 28/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

/// Class to Display Detailed information of selected list
class InfoViewController: BaseViewController {

    // MARK: UI Variable declaration
    lazy var lblDescription = UILabel()
    lazy var lblDate = UILabel()
    lazy var txtViwData = UITextView()
    lazy var imgViwInfo = UIImageView()

    // MARK: Data Variable declaration
    var listId = ""
    var type = ""
    var date = ""
    var data = ""
    var imageViw = ""
    
    // MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpUI()
        self.setUpSnapkitConstraint()
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
    }
}

// MARK: Custom Methods
extension InfoViewController {

    /// Set up UI
    func setUpUI() {
        
        self.view.addSubview(self.lblDescription)
        self.view.addSubview(self.lblDate)
        self.view.addSubview(self.txtViwData)
        self.view.addSubview(self.imgViwInfo)
    }
    
    /// Apply Snapkit constraint to respctive.
    func setUpSnapkitConstraint() {
        
        self.lblDescription.snp.makeConstraints {
            $0.top.equalTo(self.topLayoutGuide.snp.bottom).offset(20)
            $0.left.equalTo(self.view).offset(10)
            $0.right.equalTo(self.view).offset(-10)
            $0.height.equalTo(30)
        }
        
        self.lblDate.snp.makeConstraints {
            $0.top.equalTo(self.lblDescription.snp.bottom).offset(8)
            $0.left.equalTo(self.view).offset(10)
            $0.right.equalTo(self.view).offset(-10)
            $0.height.equalTo(30)
        }
        
        self.txtViwData.snp.makeConstraints {
            $0.top.equalTo(self.lblDate.snp.bottom).offset(8)
            $0.left.equalTo(self.view).offset(5)
            $0.right.equalTo(self.view).offset(-5)
            $0.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-10)
        }
        
        self.imgViwInfo.snp.makeConstraints {
            $0.top.equalTo(self.lblDate.snp.bottom).offset(8)
            $0.left.equalTo(self.view).offset(10)
            $0.right.equalTo(self.view).offset(-10)
            $0.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-10)
        }
    }
    
    /// Set data to UI
    func setData() {
        
        self.lblDescription.textAlignment = .center
        
        self.lblDescription.setContentForLabel(title: "\(Constants.Description)", fontSize: DynamicFont.FontSizeXL, FontName: DynamicFont.HelveticaNeue_Bold, textColor: GlobalColors.colorBlack)
        self.lblDate.setContentForLabel(title: "\(Constants.Date): \(self.date)", fontSize: DynamicFont.FontSizeM, FontName: DynamicFont.HelveticaNeue_Bold, textColor: GlobalColors.colorBlack)
        
        txtViwData.isEditable = false
        /// if type text
        if self.type == "text" {
            
            self.txtViwData.isHidden = false
            self.imgViwInfo.isHidden = true
            
            self.txtViwData.setContentForTextView(fontSize: DynamicFont.FontSizeM, FontName: DynamicFont.HelveticaNeue_Regular, textColor: GlobalColors.colorBlack)
            self.txtViwData.text = self.data
        }
        else {
            self.txtViwData.isHidden = true
            self.imgViwInfo.isHidden = false
            
            imgViwInfo.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgViwInfo.sd_setImage(with: URL(string: self.imageViw), placeholderImage: UIImage(named: Constants.defaultImage))
            
            imgViwInfo.contentMode = .scaleAspectFit
        }
    }
}
