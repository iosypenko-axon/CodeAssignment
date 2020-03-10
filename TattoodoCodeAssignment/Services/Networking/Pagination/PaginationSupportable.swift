//
//  PaginationSupportable.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 06/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

protocol PaginationSupportable {
    associatedtype PaginatedItem
    associatedtype Request
    var dataSource: [PaginatedItem] { get set }
    var currentPage: Int { get }
    var request: Request { get }
    func getNewData(request: Request, completion: @escaping ([PaginatedItem]) -> Void)
}

extension PaginationSupportable {
    func queryMore(completion: @escaping ([PaginatedItem]) -> Void) {
        getNewData(request: request, completion: completion)
    }
}
