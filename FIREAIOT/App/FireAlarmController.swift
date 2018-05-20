//
//  FireAlarmController.swift
//  FIREAIOT
//
//  Created by Saleem on 20/5/18.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON
import CoreLocation
import Alamofire_SwiftyJSON

class FireAlarmController {
    private init() {}
    static let shared = FireAlarmController()
    
    func store(latitude: String, longitude: String, callback: @escaping (_ success: Bool) -> ()) {
        let route = Server.getRoute(route: .fireAlarm(latitude: latitude, longitude: longitude))
        
        Alamofire.request(route.url, method: route.method, parameters: route.parameters, headers: route.headers).responseSwiftyJSON { (data) in
            
            guard let value = data.value else { return callback(false) }
            guard let statusCode = data.response?.statusCode else { return }
            print(value)
            switch statusCode {
            case 201:
                callback(true)
            default:
                callback(false)
            }
        }
    }
}


