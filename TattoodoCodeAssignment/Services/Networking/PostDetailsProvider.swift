//
//  PostDetailsProvider.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 10/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

protocol PostDetailsProvider {
    func getPostDetails(pageId: Int, completion: @escaping (Result<PostDetailsData, Error>) -> Void)
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
