//
//  Pagination.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 06/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

struct PostsListPage: Decodable {
    let data: [PostShortData]
    let meta: Meta
}

struct Meta: Decodable {
    let pagination: Pagination
}

struct Pagination: Codable {
    let total: Int
    let count: Int
    let perPage: Int
    let currentPage: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case total
        case count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}
