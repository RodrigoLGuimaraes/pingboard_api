//
//  ProfileResponse.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 15/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Foundation

struct AvatarURLs : Decodable {
    var original : String?
}

struct UserResponse : Decodable {
    let first_name : String
    let last_name : String
    let job_title : String
    let avatar_urls : AvatarURLs
}

struct ProfileResponse : Decodable {
    let users : [UserResponse]
}
