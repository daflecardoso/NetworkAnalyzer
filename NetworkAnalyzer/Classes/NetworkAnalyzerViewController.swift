//
//  NetworkAnalyzerViewController.swift
//  iCar
//
//  Created by Dafle Cardoso on 23/04/21.
//  Copyright © 2021 Dafle Cardoso. All rights reserved.
//

import UIKit

public class NetworkAnalyzerViewController: UIViewController {
    
    private let viewModel: NetworkAnalyzerViewModel

    private let cell = NetworkAnalyzerCell.self
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cell, forCellReuseIdentifier: cell.className)
        tableView.backgroundColor = .backgroundContainerViews
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(viewModel: NetworkAnalyzerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        setupDeleteButton()
        setupConstraints()
    }
    
    private func setupView() {
        navigationItem.titleView = UILabel.title("Requests")
    }

    private func setupDeleteButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.delete(target: self,
                                                                   selector: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete() {
        viewModel.cleanHistory()
        tableView.reloadData()
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func makeNetworkAnalyzerDetailViewController(
        networkAnalyzer: NetworkAnalyzerData
    ) -> NetworkAnalyzerDetailViewController {
        let viewModel = NetworkAnalyzerDetailViewModel(networkAnalyzer: networkAnalyzer)
        return NetworkAnalyzerDetailViewController(viewModel: viewModel)
    }
}

extension NetworkAnalyzerViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        let viewController = makeNetworkAnalyzerDetailViewController(networkAnalyzer: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension NetworkAnalyzerViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cell.className, for: indexPath) as! NetworkAnalyzerCell
        cell.set(with: item)
        return cell
    }
}
