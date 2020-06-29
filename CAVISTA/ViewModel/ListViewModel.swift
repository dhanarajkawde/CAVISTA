//
//  ListViewModel.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 28/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

/// Class to get and parse List Data
class ListViewModel: NSObject {
    
    static let sharedInstance = ListViewModel()
    
    /// Parse List
    /// - Parameter completion: List Data
    func parseList(completion: @escaping ([List]?) -> Void) {
        
        APIService.sharedInstance.apiCall(url: "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json", method: .get) { (response) in
            
            /// if not nil
            if let list = response {
                
                do {
                    let jsonData = try? JSONSerialization.data(withJSONObject:list)
                    let parsedList = try JSONDecoder().decode([List].self, from: jsonData!)
                    
                    completion(parsedList)
                }
                catch {
                    print(error)
                }
            }
        }
    }
}
