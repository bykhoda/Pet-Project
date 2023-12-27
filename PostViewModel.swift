//
//  PostViewModel.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit

//MARK: - Методы загрузки данных
protocol PostViewModelProtocol {
    func fetchPosts(completion: @escaping () -> Void)
    func fetchNextPage(lastId: Int?, lastSortingValues: Double?, completion: @escaping () -> Void)
}

//MARK: - Методы для делегирования из ViewController
protocol PostViewModelDelegate: AnyObject {
    func didStartedUpdateDataInTableView()
    func didStoppedUpdateDataInTableView()
    func tableViewReloadData()
    func endRefreshing()
    func presentAlert()
}

final class PostViewModel: NSObject, PostViewModelProtocol {
    weak var delegate: PostViewModelDelegate?
    private let networkClient = NetworkClient.shared
    private let networkStatus = NetworkStatusService.shared
    var router: PostRouterProtocol?
    var posts = [Post]()
    private var lastId: Int?
    private var lastSortingValues: Double?
    private var isPaginating = false
    
    //MARK: - Получение входных данных, lastId и lastSortingValues
    
    func fetchPosts(completion: @escaping () -> Void) {
        networkStatus.observeNetworkStatus { fetchType in
            switch fetchType {
            case .database:
                //MARK: Получение данных из БД
                self.posts = CoreDataManager.shared.fetchPosts()
                self.delegate?.presentAlert()
                completion()
            case .http:
                //MARK: Получение данных по сетевому запросу
                let endPoint = APIRouter.getFeed
                self.networkClient.performRequests(route: endPoint) { [weak self] (result: ResultType<Feed, Error>) in
                    guard let self = self else { return }
                    switch result {
                    case .success(let response):
                        let post = response.result
                        let itemData = post.items.filter { $0.type == .entry }.map { $0.data }
                        self.posts = itemData.map { $0.convertToPost() }
                        self.lastId = post.lastID
                        self.lastSortingValues = post.lastSortingValue
                        DispatchQueue.main.async {
                            CoreDataManager.shared.deleteAllPosts()
                            self.posts.forEach({ CoreDataManager.shared.createPost(from: $0) })
                            completion()
                        }
                    case .failure(let error):
                        print("Error fetching posts: \(error)")
                    }
                }
            }
        }
        
    }
    
    //MARK: - Пагинация данных и обновление lastId, lastSortingValues
    
    func fetchNextPage(lastId: Int?, lastSortingValues: Double?, completion: @escaping () -> Void) {
        guard let lastId = lastId, let lastSortingValues = lastSortingValues else { return }
        let endpoint = APIRouter.getPaginatedFeed(lastId: lastId, lastSortingValue: lastSortingValues)
        
        networkClient.performRequests(route: endpoint) { [weak self] (result: ResultType<Feed, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let post = response.result
                let newItemData = post.items.filter { $0.type == .entry }.map { $0.data }
                let newPosts = newItemData.map { $0.convertToPost() }
                self.posts.append(contentsOf: newPosts)
                self.lastId = post.lastID
                self.lastSortingValues = post.lastSortingValue
                DispatchQueue.main.async {
                    newPosts.forEach { CoreDataManager.shared.createPost(from: $0)}
                    completion()
                }
            case .failure(let error):
                print("Error fetching next page: \(error)")
            }
        }
    }
    
    //MARK: - Переход на экран с постом через Router (пример)
    
    private func didSelectPost(at indexPath: IndexPath) {
        guard let router = router else { return }
        let selectedPost = posts[indexPath.section]
        router.showPost(for: selectedPost)
    }
    
    //MARK: - Реализация методов для «бесконечной прокрутки»
    
    private func loadMore() {
        if !isPaginating {
            self.isPaginating = true
            delegate?.didStartedUpdateDataInTableView()
            loadMoreBegin() { [weak self] _ in
                guard let self = self else { return }
                delegate?.tableViewReloadData()
                isPaginating = false
                delegate?.didStoppedUpdateDataInTableView()
            }
        }
    }
    
    private func loadMoreBegin(loadMoreEnd: @escaping (Int) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.fetchNextPage(lastId: lastId, lastSortingValues: lastSortingValues) {
                self.delegate?.tableViewReloadData()
            }
            sleep(2)
            DispatchQueue.main.async {
                loadMoreEnd(0)
            }
        }
    }
    
    //MARK: - Обновление ленты с помощью UIRefreshControl
    
    @objc func refresh() {
        refreshBegin() { [weak self] _ in
            guard let self = self else { return }
            fetchPosts {
                self.delegate?.tableViewReloadData()
                self.delegate?.endRefreshing()
            }
        }
    }
    
    private func refreshBegin(refreshEnd: @escaping (Int) -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async {
                refreshEnd(0)
            }
        }
    }
}

//MARK: - Данные таблицы

extension PostViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let cellViewModel = PostCellViewModel()
        let cell = PostCell(style: .default, reuseIdentifier: "PostTableViewCell", post: post, cellViewModel: cellViewModel)
        
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.isOpaque = true
        cell.layer.opacity = 0.8
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return CGFloat(0)
        default: return CGFloat(20)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

}

//MARK: - Делегат таблицы

extension PostViewModel: UITableViewDelegate {
    //MARK: Переход на детальную страницу нажатием на элемент секции
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectPost(at: indexPath)
    }
}

//MARK: - Делегат UIScrollView

extension PostViewModel: UIScrollViewDelegate {
    //MARK: Выполнение пагинации при прокрутке таблицы
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            loadMore()
        }
    }
}
