//
//  ListTableViewCell.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 28/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import UIKit

/// Class to show listing
class ListTableViewCell: UITableViewCell {
    
    // MARK: Cell Identifier
    static let identifier: String = "ListTableViewCell"
    
    // MARK: UI Variable declaration
    lazy var lblDate = UILabel()
    lazy var lblData = UILabel()
    lazy var viwBack = UIView()
    lazy var imgViwNext = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configure Cell
    func configure() {
        
        self.setUpUI()
        self.setUpSnapkitConstraint()
    }
    
    /// Set up UI
    func setUpUI() {
        
        self.selectionStyle = .none
        
        self.lblDate.numberOfLines = 0
        self.lblData.numberOfLines = 0
        
        self.contentView.addSubview(self.viwBack)
        self.viwBack.addSubview(self.lblDate)
        self.viwBack.addSubview(self.lblData)
        self.viwBack.addSubview(self.imgViwNext)
        
        viwBack.backgroundColor = .white
        
        self.lblDate.setContentForLabel(title: "", fontSize: DynamicFont.FontSizeM, FontName: DynamicFont.HelveticaNeue_Bold, textColor: GlobalColors.colorBlack)
        self.lblData.setContentForLabel(title: "", fontSize: DynamicFont.FontSizeM, FontName: DynamicFont.HelveticaNeue_Regular, textColor: GlobalColors.colorBlack)
        
        self.imgViwNext.image = UIImage(named: Constants.NextImage)
        
        self.viwBack.layer.cornerRadius = 10.0
        self.viwBack.addShadow(offset: CGSize(width: 0, height: 2.0), color: UIColor.lightGray, radius: 5.5, opacity: 0.4)
        
        self.contentView.layoutSubviews()
        self.lblData.layoutSubviews()
    }
    
    /// Set Up Constraints
    func setUpSnapkitConstraint() {
        
        self.lblDate.snp.makeConstraints {
            $0.left.equalTo(self.viwBack).offset(5)
            $0.top.equalTo(self.viwBack).offset(8)
            $0.right.equalTo(self.viwBack).offset(5)
        }
        
        self.lblData.snp.makeConstraints {
            $0.left.equalTo(self.viwBack).offset(5)
            $0.top.equalTo(self.lblDate.snp.bottom).offset(5)
            $0.right.equalTo(self.viwBack).offset(-5)
            $0.bottom.equalTo(self.viwBack.snp.bottom).offset(-8)
        }
        
        self.viwBack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(0)
        }
        
        self.imgViwNext.snp.makeConstraints {
            $0.top.equalTo(self.viwBack.snp.top).offset(10)
            $0.right.equalTo(self.viwBack.snp.right).offset(-5)
            $0.height.equalTo(15)
            $0.width.equalTo(15)
        }
        
    }
    
    /// Set API data
    /// - Parameter data: data
    func setData(data:List) {
        
        //if type image
        if data.type == "image" {
            self.lblData.text = "\(Constants.Link):\n\(data.data ?? "")"
        }
        else {
            self.lblData.text = "\(Constants.Description):\n\(data.data ?? "")"
        }
        
        self.lblDate.text = "\(Constants.Date): \(data.date ?? "")"
    }
    
    /// Set Store Data
    /// - Parameter data: data
    func setRealmData(data:ListData) {
        
        //if type image
        if data.type == "image" {
            self.lblData.text = "\(Constants.Link):\n\(data.data)"
        }
        else {
            self.lblData.text = "\(Constants.Description):\n\(data.data)"
        }
        
        self.lblDate.text = "\(Constants.Date): \(data.date)"
    }
}
