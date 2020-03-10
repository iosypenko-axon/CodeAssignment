//
//  TattooDetailsPresenter.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

protocol TattooDetailsViewOutput: class {
    func didLoad()
}

class TattooDetailsPresenter {
    private var router: TattooDetailsRouter?
    private weak var view: TattooDetailsViewInput?
    private let networkProvider: PostDetailsProvider
    private let postId: Int
    
    init(networkProvider: PostDetailsProvider, postId: Int) {
        self.networkProvider = networkProvider
        self.postId = postId
    }
}

// MARK: - Public methods
extension TattooDetailsPresenter {
    func attach(router: TattooDetailsRouter) {
        self.router = router
    }
    
    func attach(view: TattooDetailsViewInput) {
        self.view = view
    }
}

// MARK: - TattooDetailsViewOutput
extension TattooDetailsPresenter: TattooDetailsViewOutput {
    func didLoad() {
        loadPostDetails()
    }
}

// MARK: - Private methods
private extension TattooDetailsPresenter {
    func loadPostDetails() {
        networkProvider.getPostDetails(pageId: postId) { result in
            //
        }
    }
}
