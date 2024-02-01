//
//  UIImageView.swift
//  Marvel
//
//  Created by Siddharth Chauhan on 19/11/23.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(url: URL?) {
        self.kf.setImage(with: url, placeholder: UIImage(systemName: Constants.Images.placeholderImage))
    }
}
