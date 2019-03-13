//
//  CustomBorder.swift
//  CreateFirebase
//
//  Created by Bao on 3/4/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func customBorder(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1
    }
}

extension UIButton {
    func makeRoundedBorder(radius: CGFloat) -> Void {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 0
    }
}

