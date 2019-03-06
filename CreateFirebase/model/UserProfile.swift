//
//  UserProfile.swift
//  CreateFirebase
//
//  Created by Bao on 2/19/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation

class UserProfile{
    
    var userM:String?
    var logoUserM:String?
    
    init(logoUser: String,user:String) {
        self.userM = user
        self.logoUserM = logoUser
        
    }
    init(logoUser: String) {
        self.logoUserM = logoUser
        
    }
}


