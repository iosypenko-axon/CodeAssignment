//
//  TattooListPresenter.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

typealias BoolCompletion = (Bool) -> Void

protocol TattooListViewOutput: class {
    var numberOfRows: Int { get }
    var shouldShowSpinner: Bool { get }
    func viewModelForCell(at index: Int) -> CellViewModel
    func didScrollToBottom()
    func didSelectCell(at index: Int)
    func didLoad()
}

class TattooListPresenter {
    var onLoadingStateChange: BoolCompletion?
    
    private var router: TattooListRouter?
    private weak var view: TattooListViewInput?
    
    private var pages: [PostShortData] = []
    private let paginationProvider: PostsListPaginatedDataProvider
        
    private var isLoading = false {
        didSet {
            onLoadingStateChange?(isLoading)
        }
    }
    
    init(paginationManager: PostsListPaginatedDataProvider) {
        self.paginationProvider = paginationManager
    }
}

// MARK: - Public methods
extension TattooListPresenter {
    func attach(router: TattooListRouter) {
        self.router = router
    }
    
    func attach(view: TattooListViewInput) {
        self.view = view
    }
}

// MARK: - TattooListViewOutput
extension TattooListPresenter: TattooListViewOutput {
    var numberOfRows: Int { pages.count }
    
    var shouldShowSpinner: Bool { paginationProvider.dataSource.count < paginationProvider.totalPages ?? 0}
    
    func viewModelForCell(at index: Int) -> CellViewModel {
        let item = paginationProvider.dataSource[index]
        
        return CellViewModel(likesCount: "\(item.counts?.likes ?? 0)",
            commentsCount: "\(item.counts?.comments ?? 0)",
            pinsCount: "\(item.counts?.pins ?? 0)",
            image: item.image)
    }
    
    func didScrollToBottom() {
        view?.showSpinner()
        loadPostsList()
    }
    
    func didSelectCell(at index: Int) {
        guard pages.count > index else { return }
        router?.openDetails(for: pages[index].id)
    }
    
    func didLoad() {
        loadPostsList()
    }
}

// MARK: - Private methods
private extension TattooListPresenter {
    func loadPostsList() {
        guard !isLoading else { return }
        isLoading = true
        paginationProvider.getNewData(request: paginationProvider.request) { [weak self] newPages in
            self?.isLoading = false
            self?.pages.append(contentsOf: newPages)
            self?.view?.update()
        }
    }
}
