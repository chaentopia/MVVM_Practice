//
//  UIView+.swift
//  MVVM_Practice
//
//  Created by 정채은 on 11/27/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
