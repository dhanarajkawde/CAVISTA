//
//  RealmHelper.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 28/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import UIKit
import RealmSwift

/// Helper to use Save, fetch Realm Objects
class RealmHelper {
    
    /// Save Object
    /// - Parameter object: object
    static func saveObject<T:Object>(object: T) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    /// Get All object
    /// - Returns: Array of Object
    static func getObjects<T:Object>()->[T] {
        let realm = try! Realm()
        let realmResults = realm.objects(T.self)
        return Array(realmResults)
    }
}
