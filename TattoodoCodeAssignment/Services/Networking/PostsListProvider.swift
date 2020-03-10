//
//  PostsListProvider.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 10/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

protocol PostsListProvider {
    func getPostsList(pageNumber: Int, completion: @escaping (Result<PostsListPage, Error>) -> Void)
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
