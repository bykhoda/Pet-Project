//
//  CustomExpandedButton.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit

//MARK: - Расширенная кнопка 􀍠 ячейки
class CustomExpandedButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = 20
        let area = self.bounds.insetBy(dx: -margin, dy: -margin)
        return area.contains(point)
    }
}
