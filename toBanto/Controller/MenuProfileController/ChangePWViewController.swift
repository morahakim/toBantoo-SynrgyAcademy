//
//  ChangePWViewController.swift
//  toBanto
//
//  Created by mora hakim on 17/11/21.
//

import UIKit

class ChangePWViewController: UIViewController, ButtonSendDataProtocol {
    
    
    @IBOutlet weak var pwLamaTextField: TextFieldController!
    @IBOutlet weak var pwBaruTextField: TextFieldController!
    @IBOutlet weak var pwKonfirmTextField: TextFieldController!
    @IBOutlet weak var btnPassword: ButtonController!
    
    var email : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ubah Password"
        pwLamaTextField.borderBottom(rightImage: UIImage(), placeholder: "Password Lama")
        pwBaruTextField.borderBottom(rightImage: UIImage(), placeholder: "Password Baru")
        pwKonfirmTextField.borderBottom(rightImage: UIImage(), placeholder: "Ulang Password Baru")
        btnPassword.clipsToBounds = true
        btnPassword.btnXib(title: "Perbarui Password")
        btnPassword.delegate = self
        
        //UserDefault
        email = UserDefaults.standard.string(forKey: "email") ?? "Unknown user"
        print(email)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func clickButton() {
        guard pwLamaTextField.textFieldXib.text != "" else {
            pwLamaTextField.label.text = "Password Lama"
            pwLamaTextField.label.textColor = .red
            pwLamaTextField.viewField.backgroundColor = .red
            return
        }
        
        guard pwBaruTextField.textFieldXib.text != "" else {
            pwBaruTextField.label.text = "Password Baru"
            pwBaruTextField.label.textColor = .red
            pwBaruTextField.viewField.backgroundColor = .red
            return
        }
        
        guard pwKonfirmTextField.textFieldXib.text != "" else {
            pwKonfirmTextField.label.text = "Ulang Password Baru"
            pwKonfirmTextField.label.textColor = .red
            pwKonfirmTextField.viewField.backgroundColor = .red
            return
        }
        
        let pw1 = pwBaruTextField.textFieldXib.text ?? ""
        let pw2 = pwKonfirmTextField.textFieldXib.text ?? ""
        let oldPw3 = pwLamaTextField.textFieldXib.text ?? ""
        
        let updatePw = UpdatePwModel(email: email, oldPassword: oldPw3, newPassword1: pw1, newPassword2: pw2)
        ApiManager.shareInstance.callingUpdatePw(updatePw: updatePw) { (result) in
            if result{
                
            }else{
                
            }
        }
        
        
    }
}
