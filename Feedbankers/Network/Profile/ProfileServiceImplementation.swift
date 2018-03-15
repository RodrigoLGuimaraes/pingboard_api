//
//  ProfileServiceImplementation.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 15/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Moya
import RxSwift

class ProfileServiceImplementation : ProfileService {
    
    private var provider : MoyaProvider<ProfileRouter>
    
    init(provider : MoyaProvider<ProfileRouter>) {
        self.provider = provider
    }
    
    func getUser(accessToken: String) -> PrimitiveSequence<SingleTrait, Response> {
        return provider.rx.request(.getUser(accessToken: accessToken))
    }
}
