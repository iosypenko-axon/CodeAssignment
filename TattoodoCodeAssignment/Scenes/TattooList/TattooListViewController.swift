//
//  TattooListViewController.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit

protocol TattooListViewInput: class {
}

class TattooListViewController: UIViewController {
    private var output: TattooListViewOutput?
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Public methods
extension TattooListViewController {
    func attach(output: TattooListViewOutput) {
        self.output = output
    }
}

extension TattooListViewController: TattooListViewInput {
    
}

// MARK: - UITableViewDelegate
extension TattooListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension TattooListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - Private methods
private extension TattooListViewController  {
    func setupView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bindTo(self.view)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
