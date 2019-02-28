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
    var userM:String?
    var postTextM:String?
   
    
    init(id:String, user:String, post:String) {
        self.idM = id
        self.userM = user
        self.postTextM = post
        
}
}

