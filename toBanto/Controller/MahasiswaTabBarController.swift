//
//  MahasiswaTabBarController.swift
//  toBanto
//
//  Created by Irianda on 24/11/21.
//

import UIKit

class MahasiswaTabBarController: UITabBarController {
    
    var ambil : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}
