//
//  CustomBorder.swift
//  CreateFirebase
//
//  Created by Bao on 3/4/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit

class CustomImage: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

extension UITextField {
    func customBorder(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderColor = UIColor(red:0.66, green:0.89, blue:0.56, alpha:1.0).cgColor
        
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.height))
//        self.leftView = paddingView
//        self.leftViewMode = UITextField.ViewMode.always
    }
}
extension UIButton {
    func makeRoundedBorder(radius: CGFloat) -> Void {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 0
//        self.layer.borderColor = UIColor.white.cgColor
    }
}

