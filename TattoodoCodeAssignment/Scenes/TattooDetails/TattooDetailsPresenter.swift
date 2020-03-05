//
//  TattooDetailsPresenter.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import Foundation

protocol TattooDetailsViewOutput: class {
}

class TattooDetailsPresenter {
    private var router: TattooDetailsRouter?
    private weak var view: TattooDetailsViewInput?
    private var interactor: TattooDetailsInteractorInput?
}

// MARK: - Public methods
extension TattooDetailsPresenter {
    func attach(router: TattooDetailsRouter) {
        self.router = router
    }
    
    func attach(interactor: TattooDetailsInteractorInput) {
        self.interactor = interactor
    }
    
    func attach(view: TattooDetailsViewInput) {
        self.view = view
    }
}

extension TattooDetailsPresenter: TattooDetailsViewOutput {
    
}

// MARK: - TattooDetailsInteractorInput
extension TattooDetailsPresenter: TattooDetailsInteractorInput {
    
}

// MARK: - TattooDetailsInteractorOutput
extension TattooDetailsPresenter: TattooDetailsInteractorOutput {}

