//
//  TattooListPresenter.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

protocol TattooListViewOutput: class {
}

class TattooListPresenter {
    private var router: TattooListRouter?
    private weak var view: TattooListViewInput?
    private var interactor: TattooListInteractorInput?
}

// MARK: - Public methods
extension TattooListPresenter {
    func attach(router: TattooListRouter) {
        self.router = router
    }
    
    func attach(interactor: TattooListInteractorInput) {
        self.interactor = interactor
    }
    
    func attach(view: TattooListViewInput) {
        self.view = view
    }
}

// MARK: - TattooListViewOutput
extension TattooListPresenter: TattooListViewOutput {
    
}

// MARK: - TattooListInteractorInput
extension TattooListPresenter: TattooListInteractorInput {
    
}

// MARK: - TattooListInteractorOutput
extension TattooListPresenter: TattooListInteractorOutput {}
