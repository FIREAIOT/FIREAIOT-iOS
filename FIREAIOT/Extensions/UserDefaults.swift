//
//  UserDefaults.swift
//  FIREAIOT
//
//  Created by Saleem on 9/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum Keys: String {
        case accessToken = "accessToken"
        case language    = "language"
        case requestId   = "requestId"
        case user        = "currentUser"
    }
    
    var accessToken: String? {
        get {
            return string(forKey: Keys.accessToken.rawValue)
        }
        set {
            set(newValue, forKey: "\(Keys.accessToken.rawValue)")
            synchronize()
        }
    }
    
    var requestId: String? {
        get {
            return string(forKey: Keys.requestId.rawValue)
        }
        set {
            set(newValue, forKey: "\(Keys.requestId.rawValue)")
            synchronize()
        }
    }
    
//    var currentUser: User? {
//        get {
//            guard let userObject = UserDefaults.standard.value(forKey: "\(Keys.user.rawValue)") as? Data else { return nil }
//
//            guard let objectsDecoded = try? JSONDecoder().decode(User.self, from: userObject) else { return nil }
//
//            return objectsDecoded
//        }
//        set {
//            guard newValue != nil else { return removeObject(forKey: Keys.user.rawValue) }
//
//            if let encoded = try? JSONEncoder().encode(newValue) {
//                UserDefaults.standard.set(encoded, forKey: "\(Keys.user.rawValue)")
//                synchronize()
//            }
//        }
//    }
}
