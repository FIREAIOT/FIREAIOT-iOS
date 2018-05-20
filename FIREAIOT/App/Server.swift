//
//  Server.swift
//  ManDoPick
//
//  Created by Saleem Hadad on 14/03/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import Alamofire
import Foundation

struct Server {
    static private let baseUrl = "https://fireaiot.com/"
    static private let apiUrl = baseUrl + "api/v1/"
    static private let clientSecret = ""
    
    static private let defaultHeaders: HTTPHeaders = [
        "Accept"       : "application/json"
    ]
    
    static private let loginHeaders: HTTPHeaders = [
        "Accept"       : "application/json",
        "Content-Type" : "application/x-www-form-urlencoded"
    ]
    
    static private func authHeaders() -> HTTPHeaders {
        return [
            "Accept": "application/json",
            "Authorization" : "Bearer " + Auth.shared.accessToken
        ]
    }
    
    enum Routes {
        case login(email: String, password: String)
        case register(name: String, email: String, password: String, mobile: String)
        case logout
        case profile
    }
    
    static func getRoute(route: Routes) -> Route {
        var routeObject: Route!
        
        switch route {
        case let .login(email, password):
            routeObject = Route(url: baseUrl + "oauth/token", method: .post, headers: loginHeaders, parameters: [
                "grant_type"    : "password",
                "client_id"     : "2",
                "client_secret" : clientSecret,
                "username"      : email,
                "password"      : password,
                "scope"         : "*",
                ])
        case let .register(name, email, password, mobile):
            routeObject = Route(url: apiUrl + "users", method: .post, headers: defaultHeaders, parameters: [
                "name"         : name,
                "email"        : email,
                "password"     : password,
                "phone_number" : mobile
                ])
        case .profile:
            routeObject = Route(url: apiUrl + "users", method: .get, headers: authHeaders(), parameters: [:])
        case .logout:
            routeObject = Route(url: apiUrl + "logout", method: .post, headers: authHeaders(), parameters: [:])
        }
        
        return routeObject
    }
}
