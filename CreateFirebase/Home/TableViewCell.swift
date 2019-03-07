//
//  TableViewCell.swift
//  CreateFirebase
//
//  Created by Bao on 3/5/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblCmt: UILabel!
    @IBOutlet weak var avtUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func  set(infor:Infor) {
//        lblCmt.text = infor.cmtInfor!.cmtM
//        
//    }
}
