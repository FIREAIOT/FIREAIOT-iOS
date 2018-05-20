//
//  Route.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 17/03/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import Alamofire
import Foundation

struct Route {
    let url        : String
    let method     : HTTPMethod
    let headers    : HTTPHeaders
    let parameters : Parameters
}
