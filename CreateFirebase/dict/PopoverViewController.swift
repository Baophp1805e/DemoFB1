//
//  PopoverViewController.swift
//  CreateFirebase
//
//  Created by Bao on 3/7/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit
import Firebase

class PopoverViewController: UIViewController {
     // MARK: - Property
    var indexPath: IndexPath!
    var ref: DatabaseReference!
    var delegateDelete: DeleteDelegate?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Handle Setting
    @IBAction func btnEdit(_ sender: Any) {
        
    }
    
    
    @IBAction func btnDelete(_ sender: Any) {
        delegateDelete?.didClickDelete(indexPath: self.indexPath)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancle(_ sender: Any) {
         self.removeAnimate()
    }
   

    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
