//
//  TogglError.swift
//  TogglBar
//
//  Created by Felipe Ferri on 25/11/16.
//  Copyright © 2016 Felipe Augusto Sviaghin Ferri. All rights reserved.
//

import Foundation

let TogglErrorDomain = "com.sailscooter.togglbar"

struct TogglError {
    static let totalGrandNotFound = TogglError.error(1, localizedDescription: "Total Grand was not returned in the summary report.")
    static let workspacesNotReturned = TogglError.error(1, localizedDescription: "The workspaces array wasn't returned by the api")
    
    static func error(_ code: Int, localizedDescription: String) -> NSError {
        let error = NSError(domain: TogglErrorDomain, code: code, userInfo: [kCFErrorLocalizedDescriptionKey as AnyHashable: localizedDescription])
        return error
    }
}
