//
//  TattooListScreen.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit
import Moya

protocol TattooListRouter: class {
    func openDetails(for id: Int)
}

final class TattooListScreen {
    private let navigationController = NavigationController()
    private weak var presenter: TattooListPresenter?
    private weak var viewController: TattooListViewController?
    private let networkService: NetworkProvider
    
    init() {
        self.networkService = NetworkService(networkProvider: MoyaProvider<PostsEndpoint>(plugins: [NetworkLoggerPlugin()]))
    }
    
    func createAsRoot() -> UIViewController {
        navigationController.setViewControllers([self.instantiateViewController()], animated: false)
        return navigationController
    }
    
    func instantiateViewController() -> TattooListViewController {
        let viewController = TattooListViewController()
        viewController.title = "Posts"
        
        let paginationProvider = PostsListPaginatedDataProvider(networkService: networkService)
        let presenter = TattooListPresenter(paginationManager: paginationProvider)
        presenter.attach(view: viewController)
        presenter.attach(router: self)
        
        viewController.attach(output: presenter)
        
        self.presenter = presenter
        self.viewController = viewController
        return viewController
    }
}

extension TattooListScreen: TattooListRouter {
    func openDetails(for id: Int) {
        TattooDetailsScreen(networkService: networkService, postId: id).push(to: navigationController)
    }
}
