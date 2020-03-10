//
//  PostDetails.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 06/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

struct PostDetails: Decodable {
    let data: PostDetailsData
}

struct PostDetailsData: Decodable {
    let id: Int
    let description: String
    let image: PostImage?
    let counts: PostCounts?
}
