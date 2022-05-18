//
//  WaitingPaymentViewController.swift
//  toBanto
//
//  Created by Irianda on 23/11/21.
//

import UIKit

class WaitingPaymentViewController: UIViewController, ButtonSendDataProtocol {
    
    
    
    @IBOutlet weak var btnDonasiAgain: ButtonController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menunggu Pembayaran"
        
        btnDonasiAgain.btnXib(title: "Donasi Lagi")
        btnDonasiAgain.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func clickButton() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabBar") as? TabbarViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    
}
