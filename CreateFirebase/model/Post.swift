//
//  Posts.swift
//  CreateFirebase
//
//  Created by Bao on 2/21/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

class Post {
    var idM:String?
    var postTextM:String?
    var imgPostM:String?
    var timeStamp:NSNumber?
    init(id:String, imgPost:String, post:String,timeStamp:NSNumber?) {
        self.idM = id
        self.postTextM = post
        self.imgPostM = imgPost
        self.timeStamp = timeStamp
    }
}

