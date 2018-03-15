//
//  UsersService.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 15/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Moya
import RxSwift

protocol UsersService {
    func getUsers(accessToken: String, pageSize : Int, page : Int, sort : Sort)->Single<Response>
}

