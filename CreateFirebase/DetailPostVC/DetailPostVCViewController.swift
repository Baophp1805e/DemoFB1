//
//  DetailPostVCViewController.swift
//  CreateFirebase
//
//  Created by Bao on 2/15/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit

class DetailPostVCViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    var imageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 detailImage.image = UIImage(named: self.imageName)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnProfile(_ sender: Any) {
    }
    
    func commonInit(_ imageName: String, title: String) {
        self.imageName = imageName
        self.title = title
    }
}
