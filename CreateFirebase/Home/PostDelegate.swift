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
    func didClickSetting(indexPath: IndexPath)
}

protocol LikeDelegate: class {
    func clickLike(indexPath: IndexPath)
}

protocol DeleteDelegate {
    func didClickDelete(idPost: String)
}

protocol EditDelegateProtocol {
    func didClickEdit(idPost: String,indexPath: IndexPath)
}
