//
//  PostRouter.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit

//MARK: - Реализация Router

protocol PostRouterProtocol {
    func showPost(for post: Post)
}

final class PostRouter: PostRouterProtocol {
    weak var viewController: PostViewController?
    
    //MARK: - Переход к выбранному посту (пример)
    func showPost(for post: Post) {
        //сюда можно передать destination UIViewController для навигации между экранами
    }
    
}
