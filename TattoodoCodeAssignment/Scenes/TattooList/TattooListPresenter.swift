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
    private let paginationManager: PaginationManager
        
    private var isLoading = false {
        didSet {
            onLoadingStateChange?(isLoading)
        }
    }
    
    init(paginationManager: PaginationManager) {
        self.paginationManager = paginationManager
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
    
    var shouldShowSpinner: Bool { paginationManager.dataSource.count < paginationManager.totalPages ?? 0}
    
    func viewModelForCell(at index: Int) -> CellViewModel {
        let item = paginationManager.dataSource[index]
        
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
        paginationManager.getNewData(request: paginationManager.request) { [weak self] newPages in
            self?.isLoading = false
            self?.pages.append(contentsOf: newPages)
            self?.view?.update()
        }
    }
}
