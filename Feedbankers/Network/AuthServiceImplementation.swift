//
//  AuthServiceImplementation.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 15/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Moya
import RxSwift

class AuthServiceImplementation : AuthService {
    
    private var provider : MoyaProvider<AuthRouter>
    
    init(provider : MoyaProvider<AuthRouter>) {
        self.provider = provider
    }
    
    func login(username: String, password: String) -> PrimitiveSequence<SingleTrait, Response> {
        return provider.rx.request(.login(username: username, password: password)) //TODO
    }
}
