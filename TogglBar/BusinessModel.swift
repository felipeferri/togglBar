//
//  BusinessModel.swift
//  TogglBar
//
//  Created by Felipe Augusto Sviaghin Ferri on 1/4/17.
//  Copyright © 2017 Felipe Augusto Sviaghin Ferri. All rights reserved.
//

import Foundation


protocol BusinessModelDelegate {
    func didUpdateTotalGrand(totalMilliseconds: Int)
}

class BusinessModel {
    static let sharedInstance = BusinessModel()
    var apiToken: String? {
        return config?["togglApiToken"] as? String
    }
    var database: Database?
    
    var delegate: BusinessModelDelegate?

    var updateTimer: Timer?

    var sinceDate = "2017-03-22".asDate!
    
    var config: [String: AnyObject]? = {
        if let configUrl = Bundle.main.url(forResource: "config", withExtension: "plist") {
            let configDict = NSDictionary(contentsOf: configUrl)
            return configDict as? [String : AnyObject]
        }
        return nil
    }()
    
    var hourlyRate: Double? {
        return (config?["hourlyRate"] as? NSNumber)?.doubleValue
    }
    
    var currency: String? {
        return config?["currency"] as? String
    }
    
    var workspaceIndex: Int {
        return config?["workspaceIndex"] as? Int ?? 0
    }
    
    var userAgent: String? {
        return config?["userAgent"] as? String
    }
    
    init() {
        if let apiToken = apiToken, let userAgent = userAgent {
            self.database = Database(apiToken: apiToken, userAgent: userAgent)
            if let database = database {
                database.getWorkspaces(failure: nil, success: { (workspaces) in
                    let workspace = workspaces[self.workspaceIndex]
                    if let workspaceId = workspace.id {
                        print ("Got workspace id: \(workspaceId)")
                        self.startUpdatingAccumulatedTime(sinceDate: Date().startOfWeek, untilDate: Date().endOfWeek, workspaceId: workspaceId)
                    }
                })
            }
        }
    }
    
    func startUpdatingAccumulatedTime(sinceDate: Date?, untilDate: Date?, workspaceId: Int) {
        updateTimer?.invalidate()
        if let database = database {
            database.getAccumulatedTime(sinceDate: sinceDate, untilDate: untilDate, workspaceId: workspaceId, failure: nil, success: { (totalMilliseconds) in
                self.delegate?.didUpdateTotalGrand(totalMilliseconds: totalMilliseconds)
            })
            updateTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { (timer) in
                database.getAccumulatedTime(sinceDate: sinceDate, untilDate: untilDate, workspaceId: workspaceId, failure: nil, success: { (totalMilliseconds) in
                    self.delegate?.didUpdateTotalGrand(totalMilliseconds: totalMilliseconds)
                })
            })
        }
    }
}
