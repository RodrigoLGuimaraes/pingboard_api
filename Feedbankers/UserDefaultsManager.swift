//
//  AppState.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 15/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Foundation
import RxSwift

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
 
    fileprivate let userDefaults = UserDefaults.standard
    
    var accessToken : String {
        didSet {
            userDefaults.set(accessToken, forKey: Constants.UserDefaults.accessTokenKey)
        }
    }
    
    
    init() {
        accessToken = userDefaults.string(forKey: Constants.UserDefaults.accessTokenKey) ?? ""
    }
}
