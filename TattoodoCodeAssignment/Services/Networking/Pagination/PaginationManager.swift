//
//  PaginationManager.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 06/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation
import Moya

final class PaginationManager: PaginationSupportable {
    typealias PaginatedItem = PostShortData
    
    private var loadedPages: [PostsListPage] = []
    private let networkService: PostsListProvider
    
    init(networkService: PostsListProvider) {
        self.networkService = networkService
    }
    
    var dataSource: [PostShortData] = []
    var currentPage: Int { loadedPages.count }
    var request: Int { currentPage + 1 }
    var totalPages: Int? { loadedPages.first?.meta.pagination.totalPages }
    var onError: ErrorCompletion?
    
    func getNewData(request: Int, completion: @escaping ([PostShortData]) -> Void) {
        if let total = totalPages, currentPage == total { return }
        let old = self.dataSource
        self.networkService.getPostsList(pageNumber: request) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.onError?(error)
            case .success(let page):
                self?.loadedPages.append(page)
                let newPosts = page.data
                self?.dataSource = old + newPosts
                completion(newPosts)
            }
        }
    }
}
