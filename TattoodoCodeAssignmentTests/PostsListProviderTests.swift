//
//  PostsListProviderTests.swift
//  PostsListProviderTests
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import XCTest
@testable import TattoodoCodeAssignment

class FakePostsListProvider: PostsListProvider {
    func getPostsList(pageNumber: Int, completion: @escaping (Result<PostsListPage, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "PostListsMock", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let page = try JSONDecoder().decode(PostsListPage.self, from: data)
            completion(.success(page))
        } catch {
            completion(.failure(error))
        }
    }
}

class PostsListProviderTests: XCTestCase {
    
    private var sutProvider: PostsListProvider!

    override func setUp() {
        sutProvider = FakePostsListProvider()
    }

    override func tearDown() {
        sutProvider = nil
    }
}

extension PostsListProviderTests {
    func test_getPostsList_Success() {
        sutProvider.getPostsList(pageNumber: 1) { result in
            var amountOfObjects = 0
            switch result {
            case .success(let page):
                amountOfObjects = page.data.count
                XCTAssertEqual(amountOfObjects, 10, "Objects count should be 10")
            
            default:
                XCTAssertNotEqual(amountOfObjects, 0, "Objects count should not be 0")
            }
        }
    }
}
