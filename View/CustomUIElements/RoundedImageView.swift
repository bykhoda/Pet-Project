//
//  RoundedImageView.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit

//MARK: - ImageView через UIBezierPath
class RoundedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCircularMask()
    }
    
    func applyCircularMask() {
        let circularPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5)
        let maskLayer = CAShapeLayer()
        maskLayer.path = circularPath.cgPath
        layer.mask = maskLayer
    }
}
