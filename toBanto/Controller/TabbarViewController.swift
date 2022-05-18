//
//  TabbarViewController.swift
//  toBanto
//
//  Created by Irianda on 16/11/21.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    var email : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}
