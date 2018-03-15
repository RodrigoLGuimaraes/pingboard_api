//
//  PingboardAPI.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 14/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Foundation
import Moya

enum AuthRouter {
    case login(username: String, password: String)
}

extension AuthRouter : TargetType {
    
    var baseURL : URL { return URL(string: Constants.Network.baseAuthenticationURL)! }
    
    var path : String {
        switch self {
        case .login:
            return "/token"
        }
    }
    
    var method : Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var headers: [String : String]? {
        var headers = [String : String]()
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        return headers
    }
    
    var parameters : [String: Any]? {
        var parameters = [String : Any]()
        
        switch self {
        case .login(let username, let password):
            parameters["grant_type"] = "password"
            parameters["username"] = username
            parameters["password"] = password
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
