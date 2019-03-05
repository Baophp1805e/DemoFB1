//
//  InforComment.swift
//  CreateFirebase
//
//  Created by Bao on 3/5/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

class CommentModel {
    var uid:String?
    var cmt:String?
    var timeStamp:NSNumber?
    
    init(uid:String, cmt:String, timeStamp:NSNumber) {
        self.uid = uid
        self.cmt = cmt
        self.timeStamp = timeStamp
    }
}
