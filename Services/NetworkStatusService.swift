//
//  NetworkStatusService.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import Network

enum FetchType<Database, HTTP> {
    case database
    case http
}

//MARK: - Проверка статуса подключения

final class NetworkStatusService {
    static let shared = NetworkStatusService()
    private let monitor = NWPathMonitor()
    private let networkClient = NetworkClient()
    private let dataManager = CoreDataManager.shared
    
    public func observeNetworkStatus(completion: @escaping (FetchType<CoreDataManager, NetworkClient>) -> Void) {
        monitor.pathUpdateHandler = { path in
            let status = path.status
            switch status {
            case .satisfied:
                completion(.http)
            default:
                completion(.database)
            }
        }
        monitor.start(queue: DispatchQueue.main)
    }
}
