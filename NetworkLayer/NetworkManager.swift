//
//  NetworkManager.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import Alamofire

enum ResultType<Data, Error> {
    case success(Data)
    case failure(Error)
}

final class NetworkClient {
    static let shared = NetworkClient()
    
    //MARK: - Общая функция выполнения запроса
    func performRequests<T: Codable>(route: APIRouter, completion: @escaping (ResultType<T, Error>) -> Void) {
        AF.request(route).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
