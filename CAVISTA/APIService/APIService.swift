//
//  APIService.swift
//  CAVISTA
//
//  Created by Dhanraj Kawade on 28/06/20.
//  Copyright © 2020 CAVISTA. All rights reserved.
//

import Foundation
import Alamofire

/// Class to interact with API
class APIService {
    
    let baseUrl = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    
    static let sharedInstance = APIService()

    /// API call
    /// - Parameters:
    ///   - url: URL
    ///   - method: HTTP Method
    ///   - completion: json
    func apiCall(url:String, method:HTTPMethod, completion: @escaping (Any?) -> Void) {
        
        AF.request(url, method: method, encoding: URLEncoding.httpBody)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.value {
                        
                        completion(json)
                    }
                    else {
                        completion(nil)
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}
