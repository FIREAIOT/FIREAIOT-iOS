//
//  Auth.swift
//  FIREAIOT
//
//  Created by Saleem on 9/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON
import Alamofire_SwiftyJSON

enum AuthStatus {
    case registered, loggedIn, loggedOut
}

extension Notification.Name {
    static let authStatus = Notification.Name("authStatus")
}

class Auth {
    private init() {}
    static let shared = Auth()
    
    typealias authCallback = (_ user: User?, _ error: AuthErrorCodes) -> ()
    
    var accessToken: String {
        get {
            return UserDefaults.standard.accessToken ?? ""
        }
        set {
            UserDefaults.standard.accessToken = newValue
        }
    }
    
    var requestId: String {
        get {
            return UserDefaults.standard.requestId ?? ""
        }
        set {
            UserDefaults.standard.requestId = newValue
        }
    }
    
    func check() -> Bool {
        return currentUser() != nil
    }
    
    func guest() -> Bool {
        return currentUser() == nil
    }
    
    func currentUser() -> User? {
        return UserDefaults.standard.currentUser
    }
    
    func profile(callback: @escaping authCallback) {
        let route = Server.getRoute(route: .profile)
        
        Alamofire.request(route.url, method: route.method, parameters: route.parameters, headers: route.headers).responseSwiftyJSON { [weak self] (data) in
            guard let value = data.value else { return callback(nil, .UnknownError) }
            guard let statusCode = data.response?.statusCode else { return callback(nil, .UnknownError) }
            
            switch statusCode {
            case 200:
                do{
                    let user = try JSONDecoder().decode(User.self, from: value["data"].rawData())
                    callback(user, .None)
                    self?.loggedIn(user: user)
                }catch {
                    callback(nil, .UnknownError)
                }
            case 401:
                callback(nil, .Unauthorized)
            default:
                callback(nil, .UnknownError)
            }
        }
    }
    
    func login(withEmail email: String, password: String, callback: @escaping authCallback) {
        let route = Server.getRoute(route: .login(email: email, password: password))
        
        Alamofire.request(route.url, method: route.method, parameters: route.parameters, headers: route.headers).responseSwiftyJSON { [weak self] (data) in
            guard let value = data.value else { return callback(nil, .UnknownError) }
            guard let statusCode = data.response?.statusCode else { return callback(nil, .UnknownError) }
            
            switch statusCode {
            case 200:
                self?.accessToken = value["access_token"].stringValue
                self?.profile(callback: callback)
            case 401:
                callback(nil, .InvalidEmailOrPassword)
            default:
                callback(nil, .UnknownError)
            }
        }
    }
    
    func register(withName name: String, email: String, password: String, mobile: String, callback: @escaping authCallback) {
        let route = Server.getRoute(route: .register(name: name, email: email, password: password, mobile: mobile))
        
        Alamofire.request(route.url, method: route.method, parameters: route.parameters, headers: route.headers).responseSwiftyJSON { [weak self] (data) in
            guard let value = data.value else { return callback(nil, .UnknownError) }
            guard let statusCode = data.response?.statusCode else { return callback(nil, .UnknownError) }
            print(value)
            switch statusCode {
            case 200:
                self?.requestId = value["data"]["requestId"].stringValue
                self?.changeAuthStatus(status: .registered)
                self?.login(withEmail: email, password: password, callback: callback)
            case 422:
                if value["errors"]["email"][0].exists() {
                    if value["errors"]["email"][0] == "he email must be a valid email address." {
                        return callback(nil, .InvalidEmailOrPassword)
                    }
                    return callback(nil, .EmailAlreadyInUse)
                }
                
                if value["errors"]["password"][0].exists() {
                    return callback(nil, .WeakPassword)
                }
                
                if value["errors"]["phone_number"][0].exists() {
                    if  value["errors"]["phone_number"][0] == "The phone number has already been taken." {
                        return callback(nil, .MobileAlreadyInUse)
                    }
                    return callback(nil, .InvalidMobile)
                }
                
                callback(nil, .UnknownError)
            default:
                callback(nil, .UnknownError)
            }
        }
    }
    
    func logout(callback: ((Bool) -> ())? = nil) {
        guard check() else { return }
        
        let route = Server.getRoute(route: .logout)
        
        Alamofire.request(route.url, method: route.method, parameters: route.parameters, headers: route.headers).responseSwiftyJSON { (data) in
            guard let statusCode = data.response?.statusCode else { return }
            switch statusCode {
            case 204:
                callback?(true)
            default:
                callback?(false)
            }
        }
        
        revokeToken()
        loggedOut()
    }
    
    
    private func changeAuthStatus(status: AuthStatus) {
        NotificationCenter.default.post(name: .authStatus, object: nil, userInfo: ["status": status])
    }
    
    private func loggedIn(user: User) {
        UserDefaults.standard.currentUser = user
        changeAuthStatus(status: .loggedIn)
    }
    
    private func loggedOut() {
        UserDefaults.standard.currentUser = nil
        changeAuthStatus(status: .loggedOut)
    }
    
    private func revokeToken() {
        accessToken = ""
    }
}
