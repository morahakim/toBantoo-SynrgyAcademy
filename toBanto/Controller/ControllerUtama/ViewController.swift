//
//  ViewController.swift
//  toBanto
//
//  Created by mora hakim on 29/10/21.
//

import UIKit

class ViewController: UIViewController, ButtonSendDataProtocol {
    
    @IBOutlet weak var ButtonCariDana: UIButton!
    
    @IBOutlet weak var buttonDonasi: UIButton!
    
    @IBOutlet weak var btnMulai: ButtonController!
    
    var roleMahasiswa : String! = "ROLE_ADMIN"
    var roleDonatur : String! = "ROLE_USER"
    
    var textController = TextFieldController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ButtonUI()
        ButtonUI2()
        btnMulai.btnXib(title: "Mulai Donasi")
        btnMulai.delegate = self
    }
    
    func ButtonUI() {
        ButtonCariDana.layer.borderColor = #colorLiteral(red: 0.2325198054, green: 0.7697016001, blue: 0.7168982625, alpha: 1)
        ButtonCariDana.layer.borderWidth = 2
        ButtonCariDana.layer.cornerRadius = 8
    }
    
    func ButtonUI2() {
        btnMulai.layer.cornerRadius = 8
    }
    
    func clickButton() {
        let nilai = roleDonatur
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "register") as? RegisterViewController
        vc?.valueRole = nilai
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnDonasi(_ sender: Any) {
        let nilai = roleMahasiswa
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "register") as? RegisterViewController
        vc?.valueRole = nilai
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

