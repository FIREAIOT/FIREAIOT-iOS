//
//  Trip.swift
//  ManDoPick
//
//  Created by Saleem Hadad on 21/03/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import Foundation

enum Categories: String, Codable {
    case FoodAndBeverage   = "Food & Beverage"
    case Fashion           = "Fashion"
    case MakeupAndPerfumes = "Makeup & Perfumes"
    case Accessories       = "Accessories"
    case Electronics       = "Electronics"
    case Jewelries         = "Jewelries"
    case Others            = "Others"
}

struct Trip: Codable {
    var id                  : Int
    var category            : Categories
    var description         : String
    var distentionLongitude : Double
    var distentionLatitude  : Double
    var receiverName        : String
    var receiverPhone       : String
    var status              : String?
}
