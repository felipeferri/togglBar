//
//  Database.swift
//  TogglBar
//
//  Created by Felipe Augusto Sviaghin Ferri on 1/4/17.
//  Copyright © 2017 Felipe Augusto Sviaghin Ferri. All rights reserved.
//

import Foundation
import Alamofire

struct TogglApi {
    static let workspaces = "https://www.toggl.com/api/v8/workspaces"
    static let weeklyReport = "https://toggl.com/reports/api/v2/weekly"
    static let summaryReport = "https://toggl.com/reports/api/v2/summary"
}


class Database {
    var apiToken: String?
    var userAgent: String?
    
    init(apiToken: String, userAgent: String) {
        self.apiToken = apiToken
        self.userAgent = userAgent
    }
    
    func getAccumulatedTime(sinceDate: Date?, untilDate: Date?, workspaceId: Int, failure fail:((Error)->())?, success succeed:@escaping ((Int)->())) {
        
        var params: [String: AnyObject] = ["workspace_id": workspaceId as AnyObject]
        
        if let sinceDate = sinceDate {
            params["since"] = sinceDate.queryString as AnyObject
        }
        
        if let untilDate = untilDate {
            params["untilDate"] = untilDate.queryString as AnyObject
        }
        
        self.query(method: .get, url: TogglApi.summaryReport, parameters: params, failure: { (error) in
            fail?(error)
        }) { (json) in
            if let jsonDict = json as? [String: AnyObject] {
                if let totalGrand = jsonDict["total_grand"] as? Int {
                    succeed(totalGrand)
                } else {
                    fail?(TogglError.totalGrandNotFound)
                }
            }
        }
    }
    
    func getWorkspaces(failure fail:((Error)->())?, success succeed:@escaping (([Workspace])->())) {
        self.query(method: .get, url: TogglApi.workspaces, parameters: nil, failure: { (error) in
            fail?(error)
        }) { (json) in
            var workspaces: [Workspace]?
            if let workspacesDictsArray = json as? [[String: AnyObject]] {
                workspaces = [Workspace]()
                for workspaceDict in workspacesDictsArray {
                    let workspace = Workspace(dict: workspaceDict)
                    workspaces!.append(workspace)
                }
                succeed(workspaces!)
            }
            fail?(TogglError.workspacesNotReturned)
        }
    }
    
    func query(method: HTTPMethod, url: String, parameters: [String: AnyObject]?, failure fail: ((NSError) ->())?, success succeed: ((_ json: Any?) -> ())?) {
        if let apiToken = apiToken, let userAgent = userAgent {
            
            let user = apiToken
            let password = "api_token"
            
            var headers: HTTPHeaders = [:]
            
            if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
                headers[authorizationHeader.key] = authorizationHeader.value
            }
            var modifiedParameters = parameters
            modifiedParameters?["user_agent"] = userAgent as AnyObject
            
            Alamofire.request(url, method: method, parameters: modifiedParameters, encoding: URLEncoding.default, headers: headers).responseJSON {
                response in
                
                guard response.error == nil else {
                    fail?(response.error! as NSError)
                    return
                }
                
                let json = response.result.value
                succeed?(json)
            }
        }
    }
}
