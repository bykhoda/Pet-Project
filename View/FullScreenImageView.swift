//
//  FullScreenImageView.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit
import SnapKit

//MARK: - View для отображения фотографии с анимацией
final class FullScreenImageViewController: UIViewController {
    var selectedImage: UIImage?
    
    lazy var fullScreenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(fullScreenImageView)
        
        fullScreenImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        fullScreenImageView.image = selectedImage
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        fullScreenImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
