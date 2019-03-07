//
//  Posts.swift
//  CreateFirebase
//
//  Created by Bao on 2/21/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

class Post {
    var uid: String?
    
    var idM:String?
    var postTextM:String?
    var imgPostM:String?
    var timeStamp:NSNumber?
    var countLikes:String?
    init(id:String, imgPost:String, uid:String, post:String, timeStamp:NSNumber?) {
        self.idM = id
        self.postTextM = post
        self.imgPostM = imgPost
        self.timeStamp = timeStamp
        self.uid = uid
    }
    
    init(id:String, imgPost:String, uid:String, post:String, timeStamp:NSNumber?,countLikes:String?) {
        self.idM = id
        self.postTextM = post
        self.imgPostM = imgPost
        self.timeStamp = timeStamp
        self.uid = uid
        self.countLikes = countLikes
    }
}

