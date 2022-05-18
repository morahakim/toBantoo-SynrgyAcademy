//
//  ChangePassViewController.swift
//  toBanto
//
//  Created by Irianda on 04/11/21.
//

import UIKit

class ChangePassViewController: UIViewController, ButtonSendDataProtocol {
    
    @IBOutlet weak var textFieldPw1: TextFieldController!
    
    @IBOutlet weak var textFieldPw2: TextFieldController!
    
    @IBOutlet weak var btnChangePw: ButtonController!
    
    var email : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ubah Password"
        self.setupHideKeyboardOnTap()
        addDoneButtonOnKeyboard()
        
        textFieldPw1.borderBottom(rightImage: UIImage(), placeholder: "Kata Sandi")
        textFieldPw2.borderBottom(rightImage: UIImage(), placeholder: "Ulang Kata Sandi")
        
        btnChangePw.btnXib(title: "Ubah Password")
        
        btnChangePw.delegate = self
        
        print(email)
        
        // Do any additional setup after loading the view.
    }
    
    
    func clickButton() {
        guard textFieldPw1.textFieldXib.text != "" else {
            textFieldPw1.label.text = "Password"
            textFieldPw1.label.textColor = .red
            textFieldPw1.viewField.backgroundColor = .red
            return
        }
        guard textFieldPw2.textFieldXib.text != "" else {
            textFieldPw2.label.text = "Password"
            textFieldPw2.label.textColor = .red
            textFieldPw2.viewField.backgroundColor = .red
            return
        }
        
        let pw1 = textFieldPw1.textFieldXib.text ?? ""
        let pw2 = textFieldPw2.textFieldXib.text ?? ""
        
        let changePw = ChangePwModel(email: email,newPassword: pw1)
        let alert = UIAlertController(title: "Harap Tunggu", message: nil, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        alert.view.addSubview(activityIndicator)
        alert.view.heightAnchor.constraint(equalToConstant: 95).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -20).isActive = true
        present(alert, animated: true)
        ApiManager.shareInstance.callingChangePw(changePw: changePw) { (succes) in
            if succes {
                self.dismiss(animated: true, completion: nil)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as? LoginViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }else{
                
            }
        }
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textFieldPw1.textFieldXib.inputAccessoryView = doneToolbar
        textFieldPw2.textFieldXib.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        textFieldPw1.textFieldXib.resignFirstResponder()
        textFieldPw2.textFieldXib.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
}
