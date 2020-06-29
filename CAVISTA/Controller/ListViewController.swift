//
//  ListViewController.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 28/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import RealmSwift

/// Class to Display List and Filtering options
class ListViewController: BaseViewController {
    
    // MARK: UI Variable declaration
    lazy var tblListViw = UITableView()
    lazy var btnFilter = UIButton()
    lazy var lblTitle = UILabel()
    lazy var viwChild = UIView()
    lazy var lblDescription = UILabel()
    lazy var lblDate = UILabel()
    lazy var txtViwData = UITextView()
    lazy var imgViwInfo = UIImageView()
    
    // MARK: Data Variable declaration
    var arrList = [List]()
    var arrTempList = [List]()
    var arrRealmList = [ListData]()
    var arrRealmTempList = [ListData]()
    
    // MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblListViw.delegate = self
        self.tblListViw.dataSource = self
        
        // Register the table view cell class and its reuse id
        self.tblListViw.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")

        self.setUpUI()
        self.setUpChildUI()
        self.setUpSnapkitConstraint()
        self.getList()
        self.handleSelectOfDropDown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK: Custom Methods
extension ListViewController {
    
    /// Set up UI
    func setUpUI() {
        
        self.view.addSubview(self.tblListViw)
        self.tblListViw.tableFooterView = UIView()
        self.tblListViw.separatorStyle = .none
        self.tblListViw.layer.cornerRadius = 10.0
        
        self.lblTitle.textAlignment = .center
        self.lblTitle.setContentForLabel(title: Constants.List, fontSize: DynamicFont.FontSizeXL, FontName: DynamicFont.HelveticaNeue_Bold, textColor: GlobalColors.colorBlack)
        
        self.btnFilter.setContentForButton(title: Constants.All, fontSize: DynamicFont.FontSizeXS, FontName: DynamicFont.HelveticaNeue_Regular, textColor: GlobalColors.colorBlue, backgroundColor: GlobalColors.colorWhite)
        self.btnFilter.addTarget(self, action: #selector(self.btnFilterClicked), for: .touchUpInside)
        self.btnFilter.setTitleColor(UIColor.blue, for: .normal)
        self.btnFilter.layer.borderWidth = 1.0
        self.btnFilter.layer.cornerRadius = 5.0
        self.btnFilter.layer.borderColor = UIColor.lightGray.cgColor
        
        self.lblDescription.setContentForLabel(title: Constants.Description, fontSize: DynamicFont.FontSizeXL, FontName: DynamicFont.HelveticaNeue_Bold, textColor: GlobalColors.colorBlack)
        
        self.txtViwData.isEditable = false
    }
    
    /// Set up Child UI for iPad
    func setUpChildUI() {
        
        self.viwChild.addSubview(self.lblDescription)
        self.viwChild.addSubview(self.lblDate)
        self.viwChild.addSubview(self.txtViwData)
        self.viwChild.addSubview(self.imgViwInfo)
        
        self.lblDescription.snp.makeConstraints {
            $0.top.equalTo(self.viwChild.snp.top).offset(20)
            $0.left.equalTo(self.viwChild.snp.left).offset(10)
            $0.right.equalTo(self.viwChild.snp.right).offset(-10)
            $0.height.equalTo(30)
        }
        
        self.lblDate.snp.makeConstraints {
            $0.top.equalTo(self.lblDescription.snp.bottom).offset(8)
            $0.left.equalTo(self.viwChild.snp.left).offset(10)
            $0.right.equalTo(self.viwChild.snp.right).offset(-10)
            $0.height.equalTo(30)
        }
        
        self.txtViwData.snp.makeConstraints {
            $0.top.equalTo(self.lblDate.snp.bottom).offset(8)
            $0.left.equalTo(self.viwChild.snp.left).offset(5)
            $0.right.equalTo(self.viwChild.snp.right).offset(-5)
            $0.bottom.equalTo(self.viwChild.snp.bottom).offset(-10)
        }
        
        self.imgViwInfo.snp.makeConstraints {
            $0.top.equalTo(self.lblDate.snp.bottom).offset(8)
            $0.left.equalTo(self.viwChild.snp.left).offset(10)
            $0.right.equalTo(self.viwChild.snp.right).offset(-10)
            $0.bottom.equalTo(self.viwChild.snp.bottom).offset(-10)
        }
    }
    
    /// Identify Current Device and Apply Snapkit constraint to respctive.
    func setUpSnapkitConstraint() {
        
        /// if iPhone
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.setUpForiPhone()
        }
        else {
            self.setUpForiPad()
        }
    }
    
    /// Set up for iPad
    func setUpForiPad() {
                
        self.view.addSubview(self.tblListViw)
        self.view.addSubview(self.btnFilter)
        self.view.addSubview(self.viwChild)
        
        self.viwChild.isHidden = true
                
        self.tblListViw.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.top.equalTo(self.btnFilter.snp.bottom).offset(5)
            $0.width.equalTo(view).multipliedBy(0.45)
            $0.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
        
        self.btnFilter.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom).offset(20)
            $0.right.equalTo(tblListViw.snp.right).offset(-2)
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
        
        self.viwChild.snp.makeConstraints {
            $0.left.equalTo(self.tblListViw.snp.right).offset(0)
            $0.top.equalTo(self.btnFilter.snp.bottom).offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }
    
    /// Set up for iPhone
    func setUpForiPhone() {
                
        self.view.addSubview(self.tblListViw)
        self.view.addSubview(self.btnFilter)
        self.view.addSubview(self.lblTitle)
        
        self.btnFilter.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom).offset(20)
            $0.right.equalTo(self.tblListViw.snp.right).offset(-2)
            $0.height.equalTo(30)
            $0.width.equalTo(80)
        }
        
        self.lblTitle.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom).offset(20)
            $0.centerX.equalTo(self.view.snp.centerX).offset(0)
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
        
        self.tblListViw.snp.makeConstraints {
            $0.top.equalTo(self.topLayoutGuide.snp.bottom).offset(60)
            $0.left.equalTo(view).offset(10)
            $0.right.equalTo(view).offset(-10)
            $0.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }
    
    /// Filter Button Action
    @objc func btnFilterClicked() {
        
        self.showSelectionListDropdown(anchorView: self.btnFilter, data: [Constants.All, Constants.Image, Constants.Text])
    }
    
    /// Get selected value from Dropdown
    func handleSelectOfDropDown() {
        
        // Action triggered on selection
        self.selectionListDropDown.selectionAction = { (index, item) in
            
            /// if 0 index
            if index == 0 {
                
                self.btnFilter.setTitle(Constants.All, for: .normal)
                ///if internet connection available
                if Reachability.isConnectedToNetwork() {
                    self.arrTempList = self.arrList
                }
                else {
                    self.arrRealmTempList = self.arrRealmList
                }
            }
            else if index == 1 { /// if 1 index
                
                self.btnFilter.setTitle(Constants.Image, for: .normal)
                ///if internet connection available
                if Reachability.isConnectedToNetwork() {
                    self.arrTempList = self.arrList.filter { $0.type == "image" }
                }
                else {
                    self.arrRealmTempList = self.arrRealmList.filter { $0.type == "image" }
                }
            }
            else {
                
                self.btnFilter.setTitle(Constants.Text, for: .normal)
                ///if internet connection available
                if Reachability.isConnectedToNetwork() {
                    self.arrTempList = self.arrList.filter { $0.type == "text" }
                }
                else {
                    self.arrRealmTempList = self.arrRealmList.filter { $0.type == "text" }
                }
            }
            
            DispatchQueue.main.async {
                
                self.tblListViw.reloadData()
            }
        }
    }
    
    func saveDataToRealm(data:[List]) {
        
        for d in data {
            
            let myList = ListData()
            myList.listId = d.id ?? ""
            myList.type = d.type ?? ""
            myList.date = d.date ?? ""
            myList.data = d.data ?? ""
            
            RealmHelper.saveObject(object: myList)
        }
    }
    
    /// Fetch Data of List from Database
    func getDataFromRealm() {
        
        self.arrRealmList = RealmHelper.getObjects()
        self.arrRealmTempList = RealmHelper.getObjects()
        
        DispatchQueue.main.async {
            
            self.stopProgress()
            self.tblListViw.reloadData()
            self.tblListViw.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    /// Check internet connection while navigating
    func checkInternetConnectionWhileNavigating() {
        
        ///if internet connection available
        if !Reachability.isConnectedToNetwork() {
            ///if data nil
            if self.arrRealmTempList.count <= 0 {
                
                self.getDataFromRealm()
                return
            }
        }
        else {
            if self.arrRealmTempList.count <= 0 {
                
                self.getList()
                return
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Reachability.isConnectedToNetwork() == true ? self.arrTempList.count : self.arrRealmTempList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ListTableViewCell = self.tblListViw.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        ///if internet connection available
        if Reachability.isConnectedToNetwork() {
            
            cell.setData(data: self.arrTempList[indexPath.row])
        }
        else {
            cell.setRealmData(data: self.arrRealmTempList[indexPath.row])
        }
        cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            ///if iPhone
            if UIDevice.current.userInterfaceIdiom == .phone {
                
                self.checkInternetConnectionWhileNavigating()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let infoViewController:InfoViewController = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
                infoViewController.listId = Reachability.isConnectedToNetwork() == true ? self.arrTempList[indexPath.row].id ?? "" : self.arrRealmTempList[indexPath.row].listId
                infoViewController.type = Reachability.isConnectedToNetwork() == true ? self.arrTempList[indexPath.row].type ?? "" : self.arrRealmTempList[indexPath.row].type
                infoViewController.date = Reachability.isConnectedToNetwork() == true ? self.arrTempList[indexPath.row].date ?? "" : self.arrRealmTempList[indexPath.row].date
                infoViewController.data = Reachability.isConnectedToNetwork() == true ? self.arrTempList[indexPath.row].data ?? "" : self.arrRealmTempList[indexPath.row].data
                infoViewController.imageViw = Reachability.isConnectedToNetwork() == true ? self.arrTempList[indexPath.row].data ?? "" : self.arrRealmTempList[indexPath.row].data
                self.navigationController?.pushViewController(infoViewController, animated: true)
            }
            else {
                
                self.viwChild.isHidden = false
                self.checkInternetConnectionWhileNavigating()
                
                self.lblDate.setContentForLabel(title: "\(Constants.Date): \(Reachability.isConnectedToNetwork() == true ? self.arrTempList[indexPath.row].date ?? "" : self.arrRealmTempList[indexPath.row].date)", fontSize: DynamicFont.FontSizeM, FontName: DynamicFont.HelveticaNeue_Bold, textColor: GlobalColors.colorBlack)
                
                let typeToCheck = Reachability.isConnectedToNetwork() == true ? self.arrTempList[indexPath.row].type ?? "" : self.arrRealmTempList[indexPath.row].type
                ///if type is text
                if typeToCheck == "text" {
                    
                    self.txtViwData.isHidden = false
                    self.imgViwInfo.isHidden = true
                    
                    self.txtViwData.setContentForTextView(fontSize: DynamicFont.FontSizeM, FontName: DynamicFont.HelveticaNeue_Regular, textColor: GlobalColors.colorBlack)
                    self.txtViwData.text = Reachability.isConnectedToNetwork() == true ? self.arrTempList[indexPath.row].data ?? "" : self.arrRealmTempList[indexPath.row].data
                }
                else {
                    self.txtViwData.isHidden = true
                    self.imgViwInfo.isHidden = false
                    
                    self.imgViwInfo.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    self.imgViwInfo.sd_setImage(with: URL(string: Reachability.isConnectedToNetwork() == true ? self.arrTempList[indexPath.row].data ?? "" : self.arrRealmTempList[indexPath.row].data), placeholderImage: UIImage(named: Constants.defaultImage))
                    self.imgViwInfo.contentMode = .scaleAspectFit
                }
            }
        }
    }
}

// MARK: API Calls
extension ListViewController {
    
    // MARK: - API Calls
    func getList() {
        
        DispatchQueue.main.async {
            
            self.showProgress(msg: "")
        }
        ///if internet connection available
        if Reachability.isConnectedToNetwork() {
            
            ListViewModel.sharedInstance.parseList { (list) in
                
                if let _ = list {
                    
                    self.arrList = list!
                    self.arrTempList = list!
                    
                    DispatchQueue.main.async {
                        
                        self.saveDataToRealm(data: self.arrList)
                        
                        self.stopProgress()
                        self.tblListViw.reloadData()
                        self.tblListViw.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                }
            }
        }
        else {
            
            self.getDataFromRealm()
        }
    }
}
