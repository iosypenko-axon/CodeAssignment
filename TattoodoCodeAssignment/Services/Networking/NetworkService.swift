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

protocol PostsListProvider {
    func getPostsList(pageNumber: Int, completion: @escaping (Result<PostsListPage, Error>) -> Void)
}

protocol PostDetailsProvider {
    func getPostDetails(pageId: Int, completion: @escaping (Result<PostDetailsData, Error>) -> Void)
}

protocol NetworkProvider: PostsListProvider, PostDetailsProvider {}

class NetworkService: NetworkProvider {
    private let networkProvider: MoyaProvider<PostsEndpoint>

    init(networkProvider: MoyaProvider<PostsEndpoint>) {
        self.networkProvider = networkProvider
    }
}

extension NetworkService {
    func getPostsList(pageNumber: Int, completion: @escaping (Result<PostsListPage, Error>) -> Void) {
        networkProvider.request(.getPostsList(pageNumber: pageNumber)) { result in
            switch result {
            case .success(let response):
                do {
                    let page = try JSONDecoder().decode(PostsListPage.self, from: response.data)
                    completion(.success(page))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension NetworkService {
    func getPostDetails(pageId: Int, completion: @escaping (Result<PostDetailsData, Error>) -> Void) {
        networkProvider.request(.getPostDetails(postId: pageId)) { result in
            switch result {
            case .success(let response):
                do {
                    let page = try JSONDecoder().decode(PostDetails.self, from: response.data)
                    completion(.success(PostDetailsData(id: page.data.id,
                                                        description: page.data.description,
                                                        image: page.data.image,
                                                        counts: page.data.counts)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
