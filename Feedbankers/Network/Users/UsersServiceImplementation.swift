//
//  UsersServiceImplementation.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 15/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Moya
import RxSwift

class UsersServiceImplementation : UsersService {
    
    private var provider : MoyaProvider<UsersRouter>
    
    init(provider : MoyaProvider<UsersRouter>) {
        self.provider = provider
    }
    
    func getUsers(accessToken: String, pageSize : Int, page : Int, sort : Sort) -> PrimitiveSequence<SingleTrait, Response> {
        return provider.rx.request(.getUsers(accessToken: accessToken, pageSize: pageSize, page: page, sort: sort))
    }
}

