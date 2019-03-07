//
//  PostDelegate.swift
//  CreateFirebase
//
//  Created by Bao on 3/5/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

protocol PostDelegate: class{
    func didClickComment(indexPath: IndexPath)
}

protocol SettingDelegate: class {
    func didClickSetting() 
}

protocol LikeDelegate: class {
    func clickLike(indexPath: IndexPath)
}
