//
//  NetworkService.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 06/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation
import Moya

typealias ErrorCompletion = (Error) -> Void

protocol NetworkProvider: PostsListProvider, PostDetailsProvider {}

class NetworkService: NetworkProvider {
    internal let networkProvider: MoyaProvider<PostsEndpoint>

    init(networkProvider: MoyaProvider<PostsEndpoint>) {
        self.networkProvider = networkProvider
    }
}
