//
//  DataModel.swift
//  TogglBar
//
//  Created by Felipe Augusto Sviaghin Ferri on 2/4/17.
//  Copyright © 2017 Felipe Augusto Sviaghin Ferri. All rights reserved.
//

import Foundation

class Workspace {
    var id: Int?
    var name: String?
    var profile: Int?
    var premium: Bool?
    var admin: Bool?
    var defaultHourlyRate: Float?
    var defaultCurrency: String?
    var onlyAdminsMayCreateProjects: Bool?
    var onlyAdminsSeeBillableRates: Bool?
    var onlyAdminsSeeTeamDashboard: Bool?
    var projectsBillableByDefault: Bool?
    var rounding: Float?
    var roundingMinutes: Float?
    var apiToken: String?
    var at: String?
    var icalEnabled: Bool?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String ?? ""
        profile = dict["profile"] as? Int
        premium = dict["premium"] as? Bool
        admin = dict["admin"] as? Bool
        defaultHourlyRate = dict["default_hourly_rate"] as? Float
        defaultCurrency = dict["default_currency"] as? String
        onlyAdminsMayCreateProjects = dict["only_admins_may_create_projects"] as? Bool
        onlyAdminsSeeBillableRates = dict["only_admins_see_billable_rates"] as? Bool
        onlyAdminsSeeTeamDashboard = dict["only_admins_see_team_dashboard"] as? Bool
        projectsBillableByDefault = dict["projects_billable_by_default"] as? Bool
        rounding = dict["rounding"] as? Float
        roundingMinutes = dict["rounding_minutes"] as? Float
        apiToken = dict["api_token"] as? String
        at = dict["at"] as? String
        icalEnabled = dict["ical_enabled"] as? Bool
    }
}
