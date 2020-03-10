//
//  TattooListViewController.swift
//  TattoodoCodeAssignment
//
//  Created by Ivan Osypenko on 05/03/2020.
//  Copyright © 2020 iosypenk. All rights reserved.
//

import UIKit

protocol TattooListViewInput: class {
    func update()
    func showSpinner()
}

class TattooListViewController: UIViewController {
    private var output: TattooListViewOutput?
    
    private let cellIdentifier = TattooListCell.reuseIdentifier
    private let tableView = UITableView()
    private var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        output?.didLoad()
    }
}

// MARK: - Public methods
extension TattooListViewController {
    func attach(output: TattooListViewOutput) {
        self.output = output
    }
}

extension TattooListViewController: TattooListViewInput {
    func update() {
        tableView.reloadData()
        activityIndicator?.stopAnimating()
    }
    
    func showSpinner() {
        activityIndicator?.startAnimating()
    }
}

// MARK: - UITableViewDelegate
extension TattooListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentSize.height > scrollView.frame.size.height,
            scrollView.contentOffset.y + scrollView.frame.size.height + 20.0 > scrollView.contentSize.height else { return }
        output?.didScrollToBottom()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectCell(at: indexPath.row)
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}

// MARK: - UITableViewDataSource
extension TattooListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { output?.numberOfRows ?? 0 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TattooListCell,
            let cellModel = output?.viewModelForCell(at: indexPath.row) else { return UITableViewCell() }
        cell.configure(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellModel = output?.viewModelForCell(at: indexPath.row) else { return .zero }
        let labelsHeight: CGFloat = 20.0
        return cellModel.getAdjustedImageHeight(for: tableView.bounds.width) + labelsHeight
    }
}

// MARK: - Private methods
private extension TattooListViewController  {
    func setupView() {
        view.addSubview(tableView)
        tableView.bindTo(self.view)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.contentInset.bottom = 100
        tableView.estimatedRowHeight = 128
        tableView.tableFooterView = getActivityFooterView()
    }
    
    func getActivityFooterView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        self.activityIndicator = activityIndicator
        return view
    }
}
