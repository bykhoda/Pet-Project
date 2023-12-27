//
//  DependencyManager.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit

//MARK: - Иньекция зависимостей

final class DependencyManager {
    static let shared = DependencyManager()
    
    //MARK: - Сборка PostViewController
    func buildPostModule() -> UIViewController {
        let viewModel = PostViewModel()
        let router = PostRouter()
        viewModel.router = router
        
        let viewController = PostViewController(viewModel: viewModel)
        router.viewController = viewController
        
        return viewController
    }
}
