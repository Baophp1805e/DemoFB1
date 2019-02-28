//
//  PostTableViewCell.swift
//  CreateFirebase
//
//  Created by Bao on 2/13/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func commonInit(_ imageName: String, user: String, post:String) {
        logoImage.image = UIImage(named: imageName)
        userLabel.text = user
        postLabel.text = post
    
    }
    func  set(post:Post) {
        postLabel.text = post.postTextM
        userLabel.text = post.userM
    }
    
    
}
