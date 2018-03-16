//
//  Constants.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 13/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Foundation

struct Constants {
    struct Network {
        #if DEBUG
        static let baseAuthenticationURL = "https://app.pingboard.com/oauth"
        static let baseApplicationURL = "https://app.pingboard.com/api/v2"
        #else
        static let baseAuthenticationURL = "https://app.pingboard.com/oauth"
        static let baseApplicationURL = "https://app.pingboard.com/api/v2"
        #endif
    }
    struct UserDefaults {
        static let accessTokenKey = "accTokenKey"
    }
}
