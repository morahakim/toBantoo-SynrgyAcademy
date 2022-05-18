//
//  ForgotPwViewController.swift
//  toBanto
//
//  Created by Irianda on 31/10/21.
//

import UIKit

class ForgotPwViewController: UIViewController, UIGestureRecognizerDelegate, ButtonSendDataProtocol {
    
    
    @IBOutlet weak var textFieldEmail: TextFieldController!
    
    
    @IBOutlet weak var btnSendEmail: ButtonController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Lupa Password"
        addDoneButtonOnKeyboard()
        self.setupHideKeyboardOnTap()
        
        textFieldEmail.borderBottom(rightImage: UIImage(), placeholder: "Email")
        btnSendEmail.btnXib(title: "Kirim")
        btnSendEmail.delegate = self
    }
    
    func clickButton() {
        let email = textFieldEmail.textFieldXib.text ?? ""
        guard  textFieldEmail.textFieldXib.text != ""  else {
            textFieldEmail.label.text = "Email"
            textFieldEmail.label.textColor = .red
            textFieldEmail.viewField.backgroundColor = .red
            return
        }

        let forgotModel = ForgotPasswordModel(email: email)
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
              ApiManager.shareInstance.callingForgotApi(forgot: forgotModel) { (result) in
                if result {
                    self.dismiss(animated: true, completion: nil)
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "otp") as? TextFieldOtpViewController
                    vc?.email = self.textFieldEmail.textFieldXib.text
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
        
        textFieldEmail.textFieldXib.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        textFieldEmail.textFieldXib.resignFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}
