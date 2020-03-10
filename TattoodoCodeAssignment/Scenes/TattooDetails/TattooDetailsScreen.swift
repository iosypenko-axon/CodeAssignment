//
//  TattooDetailsScreen.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit

protocol TattooDetailsRouter: class {
    func backAction()
}

final class TattooDetailsScreen {
    private weak var presenter: TattooDetailsPresenter?
    private weak var viewController: TattooDetailsViewController?
    private let networkService: NetworkProvider
    private let postId: Int
    
    init(networkService: NetworkProvider, postId: Int) {
        self.networkService = networkService
        self.postId = postId
    }
    
    func push(to navController: UINavigationController, animated: Bool = true) {
        navController.pushViewController(instantiateViewController(), animated: animated)
    }
    
    func instantiateViewController() -> TattooDetailsViewController {
        let viewController = TattooDetailsViewController()
        
        let presenter = TattooDetailsPresenter(networkProvider: networkService, postId: postId)
        presenter.attach(view: viewController)
        presenter.attach(router: self)
        
        viewController.attach(output: presenter)
        
        self.presenter = presenter
        self.viewController = viewController
        return viewController
    }
}

extension TattooDetailsScreen: TattooDetailsRouter {
    func backAction() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
