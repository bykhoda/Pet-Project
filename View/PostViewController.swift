//
//  PostViewController.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit
import SnapKit

final class PostViewController: UIViewController {
    
    private let tableView = UITableView()
    private var viewModel: PostViewModel!
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView()
    private let alert = UIAlertController()
    private var alertIsShown = false
    
    convenience init(viewModel: PostViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupViews()
    }
    
    //MARK: - Установка TableView
    
    private func setupViews() {
        tableView.backgroundColor = UIColor(named: "tableViewBackground")
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostTableViewCell")
        viewModel.fetchPosts(completion: {
            self.tableView.reloadData()
        })
        self.tableView.dataSource = viewModel
        self.tableView.delegate = viewModel
        refreshControl.addTarget(viewModel, action: #selector(viewModel.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        activityIndicator.color = .gray
        tableView.tableFooterView = activityIndicator
        alert.title = "Ошибка сети"
        alert.message = "проверьте подключение"
        let alertAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(alertAction)
    }
    
}

//MARK: - Делегирование методов в ViewModel

extension PostViewController: PostViewModelDelegate {
    func presentAlert() {
        if !alertIsShown {
            present(alert, animated: true)
            alertIsShown = true
        } else {
            alertIsShown = false
            alert.dismiss(animated: true)
        }
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func didStoppedUpdateDataInTableView() {
        activityIndicator.stopAnimating()
    }
    
    func didStartedUpdateDataInTableView() {
        activityIndicator.startAnimating()
    }
    
    func tableViewReloadData() {
        tableView.reloadData()
    }
}
