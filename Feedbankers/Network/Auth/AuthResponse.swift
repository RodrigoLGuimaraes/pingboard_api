//
//  AuthResponse.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 15/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Foundation

struct AuthResponse : Decodable {
    let access_token : String
    let refresh_token : String
}
