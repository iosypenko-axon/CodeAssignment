//
//  PostDetailsProviderTests.swift
//  PostDetailsProviderTests
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import XCTest
@testable import TattoodoCodeAssignment

class FakePostDetailsProvider: PostDetailsProvider {
    func getPostDetails(pageId: Int, completion: @escaping (Result<PostDetailsData, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "PostDetailsMock", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let page = try JSONDecoder().decode(PostDetails.self, from: data)
            let pageDetails = PostDetailsData(id: page.data.id,
                                              description: page.data.description,
                                              image: page.data.image,
                                              counts: page.data.counts)
            completion(.success(pageDetails))
        } catch {
            completion(.failure(error))
        }
    }
}

class PostDetailsProviderTests: XCTestCase {
    
    private var sutProvider: PostDetailsProvider!

    override func setUp() {
        sutProvider = FakePostDetailsProvider()
    }

    override func tearDown() {
        sutProvider = nil
    }
}

extension PostDetailsProviderTests {
    func test_getPostDetails_Success() {
        sutProvider.getPostDetails(pageId: 827579) { result in
            switch result {
            case .success(let details):
                let model = DetailsViewModel(likesCount: String(details.counts?.likes ?? 0),
                                             commentsCount: String(details.counts?.comments ?? 0),
                                             pinsCount: String(details.counts?.pins ?? 0),
                                             image: details.image,
                                             description: details.description)
                
                let likesString = "Likes: " + model.likesCount
                let commentsString = "Comments: " + model.commentsCount
                let pinsString = "Pins: " + model.pinsCount
                XCTAssertEqual(likesString, "Likes: 1399", "Should be equal")
                XCTAssertEqual(commentsString, "Comments: 9", "Should be equal")
                XCTAssertEqual(pinsString, "Pins: 5042", "Should be equal")
                
                let descriptionString = model.description
                XCTAssertEqual(descriptionString, "Tattoo by Bill Canales #BillCanales #tattoodoambassador #Japanese #Japanesetattoo #Irezumi #dragon #clouds #blackandgrey", "Should be equal")
                
                XCTAssertNotNil(model.image, "Should not be nil")
                    
            default:
                XCTFail()
            }
        }
    }
}
