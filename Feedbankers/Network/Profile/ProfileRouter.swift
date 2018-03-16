//
//  ProfileRouter.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 15/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//


import Foundation
import Moya

enum ProfileRouter {
    case getUser(accessToken: String)
}

extension ProfileRouter : TargetType {
    
    var baseURL : URL { return URL(string: Constants.Network.baseApplicationURL)! }
    
    var path : String {
        switch self {
        case .getUser:
            return "/users/me"
        }
    }
    
    var method : Moya.Method {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    var headers: [String : String]? {
        var headers = [String : String]()
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        switch self {
        case .getUser(let accessToken):
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        return headers
    }
    
    var parameters : [String: Any]? {
        var parameters = [String : Any]()
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
