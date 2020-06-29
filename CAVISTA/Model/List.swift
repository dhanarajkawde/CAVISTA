//
//  List.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 28/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import Foundation
import RealmSwift

/// Struct to parse API response
struct List : Codable {
    
    var id:String?
    var type:String?
    var date:String?
    var data:String?
}

/// Class to store Ream List Object
@objcMembers class ListData: Object {
    
    dynamic var listId: String = ""
    dynamic var type: String = ""
    dynamic var date: String = ""
    dynamic var data: String = ""
    
    /// Set Primary Key
    /// - Returns: key
    override static func primaryKey() -> String?
    {
        return "listId"
    }
}
