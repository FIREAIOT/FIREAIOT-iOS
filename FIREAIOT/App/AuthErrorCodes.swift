//
//  AuthErrorCodes.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 17/03/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import Foundation

enum AuthErrorCodes {
    case InvalidEmailOrPassword
    case UserDisabled
    case EmailAlreadyInUse
    case WeakPassword
    case MobileAlreadyInUse
    case InvalidUserToken
    case InvalidVerificationCode
    case PhoneAlreadyVerified
    case TooManyRequest
    case UnknownError
    case Unauthorized
    case InvalidMobile
    case None
}
