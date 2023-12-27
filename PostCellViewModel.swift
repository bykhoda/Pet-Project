//
//  PostCellViewModel.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit

final class PostCellViewModel {
    
    //MARK: - Метод вызывающий переход на FullScreenImageViewController при нажатии на изображении
    @objc func cellImageTapped(_ gestureRecognizer: UIGestureRecognizer) {
        guard let tappedImageView = gestureRecognizer.view as? UIImageView,
              let image = tappedImageView.image else { return }
        
        let fullScreenVC = FullScreenImageViewController()
        fullScreenVC.selectedImage = image
        
        if let topWindowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first {
            if let topController = topWindowScene.windows.first?.rootViewController {
                topController.present(fullScreenVC, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Конвертация date(Int) в String:
    
    func timeAgoString(from int: Int) -> String {
        let timestamp = TimeInterval(int)
        let currentTime = Date().timeIntervalSince1970
        let timeDifference = Int(currentTime - timestamp)
        
        switch timeDifference {
        case 0..<60:
            return "\(timeDifference) сек"
        case 60..<3600:
            return "\(timeDifference / 60) мин"
        case 3600..<86400:
            return "\(timeDifference / 3600) ч"
        case 86400..<604800:
            return "\(timeDifference / 86400) д"
        default:
            return "больше недели"
        }
    }
    
}
