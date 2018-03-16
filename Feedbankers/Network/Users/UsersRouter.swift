//
//  UsersRouter.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 15/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Foundation
import Moya

enum Sort : String {
    case StartDate = "start_date"
    case FirstName = "first_name"
    case LastName = "last_name"
    case JobTitle = "job_title"
}

enum UsersRouter {
    case getUsers(accessToken: String, pageSize : Int, page : Int, sort : Sort)
}

extension UsersRouter : TargetType {
    
    var baseURL : URL { return URL(string: Constants.Network.baseApplicationURL)! }
    
    var path : String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
    
    var method : Moya.Method {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    var headers: [String : String]? {
        var headers = [String : String]()
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        switch self {
        case .getUsers(let accessToken, let pageSize, let page, let sort):
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        return headers
    }
    
    var parameters : [String: Any]? {
        var parameters = [String : Any]()
        
        switch self {
        case .getUsers(let accessToken, let pageSize, let page, let sort):
            parameters["page_size"] = pageSize
            parameters["page"] = page
            parameters["sort"] = sort.rawValue
        }
        
        return parameters
    }
    
    var parameterEncoding : ParameterEncoding {
        return URLEncoding.default
    }
    
    // Sample data is data for testing purposes. You can for example set mock data and test your requests even if your server is not avaialable right now.
    var sampleData : Data {
        return Data()
    }
    
    // Set task type, you can set request, download, upload etc.
    var task : Task {
        if let parameters = self.parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        } else {
            return .requestPlain
        }
    }
}
