//
//  PostsEndpoint.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 06/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation
import Moya

enum PostsEndpoint {
    case getPostsList(pageNumber: Int)
    case getPostDetails(postId: Int)
}

extension PostsEndpoint: TargetType {
    var baseURL: URL { URL(string: "https://backend-api.tattoodo.com/api/v2/")! }

    var path: String {
        switch self {
        case .getPostsList:
            return "search/posts"
        case .getPostDetails(let postId):
            return "posts/\(postId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPostsList,
             .getPostDetails:
            return .get
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Task {
        switch self {
        case .getPostsList(let pageNumber):
            return .requestParameters(parameters: ["page": pageNumber], encoding: URLEncoding.default)
        case .getPostDetails:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { nil }
}
