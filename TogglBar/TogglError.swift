//
//  SalemovingError.swift
//  SaleMoving
//
//  Created by Felipe Ferri on 25/11/16.
//  Copyright © 2016 Felipe Augusto Sviaghin Ferri. All rights reserved.
//

import Foundation

let SalemovingErrorDomain = "com.sailscooter.salemoving"

struct SalemovingError {
    static let InvalidUsernamePassword = SalemovingError.error(1, localizedDescription: "Invalid username or password")
    static let IpAddressNotSet = SalemovingError.error(7, localizedDescription: "Please set an ip address for the server")
    static let InvalidWishRef = SalemovingError.error(8, localizedDescription: "Received invalid wishref when creating new wish")
    
    static func error(_ code: Int, localizedDescription: String) -> NSError {
        let error = NSError(domain: SalemovingErrorDomain, code: code, userInfo: [kCFErrorLocalizedDescriptionKey as AnyHashable: localizedDescription])
        return error
    }
}
