//
//  TattooListScreen.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit

protocol TattooListRouter: class {
    
}

final class TattooListScreen {
    private let navigationController = NavigationController()
    private weak var presenter: TattooListPresenter?
    private weak var viewController: TattooListViewController?
    
    func createAsRoot() -> UIViewController {
        navigationController.setViewControllers([self.instantiateViewController()], animated: false)
        return navigationController
    }
    
    func instantiateViewController() -> TattooListViewController {
        let viewController = TattooListViewController()
        
        let presenter = TattooListPresenter(paginationManager: PaginationManager())
        presenter.attach(view: viewController)
        presenter.attach(router: self)
        
        viewController.attach(output: presenter)
        
        self.presenter = presenter
        self.viewController = viewController
        return viewController
    }
}

extension TattooListScreen: TattooListRouter {
}
