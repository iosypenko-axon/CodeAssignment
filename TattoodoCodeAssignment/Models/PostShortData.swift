//
//  PostShortData.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 06/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

struct PostShortData: Decodable {
    let id: Int
    let image: PostImage
    let counts: PostCounts
}

struct PostImage: Decodable {
    let url: String
    let width: Int
    let height: Int
}

struct PostCounts: Decodable {
    let likes: Int
    let comments: Int
    let pins: Int
}
