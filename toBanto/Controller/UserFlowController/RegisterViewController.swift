//
//  RegisterViewController.swift
//  toBanto
//
//  Created by mora hakim on 31/10/21.
//

import UIKit

class RegisterViewController: UIViewController, ButtonSendDataProtocol {
    
    @IBOutlet weak var textFieldEmail: TextFieldController!
    
    @IBOutlet weak var textFieldPw: TextFieldController!
    
    @IBOutlet weak var textFieldPw2: TextFieldController!
    
    @IBOutlet weak var btnRegister: ButtonController!
    
    @IBOutlet weak var buttonMasuk: UIButton!
    
    var valueRole : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHideKeyboardOnTap()
        addDoneButtonOnKeyboard()
        
        textFieldEmail.borderBottom(rightImage: UIImage(), placeholder: "Email")
        textFieldPw.borderBottom(rightImage: UIImage(), placeholder: "Password")
        textFieldPw2.borderBottom(rightImage: UIImage(), placeholder: "Confirm Password")
        btnRegister.btnXib(title: "Daftar")
        btnRegister.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    //buttonLogin
    func clickButton() {
        guard textFieldEmail.textFieldXib.text != "" else {
            textFieldEmail.label.text = "Email"
            textFieldEmail.label.textColor = .red
            textFieldEmail.viewField.backgroundColor = .red
            return
        }
        guard textFieldPw.textFieldXib.text != "" else {
            textFieldPw.label.text = "Password"
            textFieldPw.label.textColor = .red
            textFieldPw.viewField.backgroundColor = .red
            return
        }
        guard let PWs = textFieldPw2.textFieldXib.text else {
            textFieldPw2.label.text = "Confirm Password"
            textFieldPw2.label.textColor = .red
            textFieldPw2.viewField.backgroundColor = .red
            return}
        
        let email = textFieldEmail.textFieldXib.text ?? ""
        let password = textFieldPw.textFieldXib.text ?? ""
        let register = RegisterModel(username: email, password: password, role: valueRole)
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
        ApiManager.shareInstance.callingRegisterApi(register: register) { (isSuccess) in
            
            DispatchQueue.main.async{
            self.dismiss(animated: true, completion: {
                
                    if isSuccess {
                      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as? LoginViewController
                      vc?.valueM = self.valueRole
                      self.navigationController?.pushViewController(vc!, animated: true)
                    }
            })
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
        textFieldPw.textFieldXib.inputAccessoryView = doneToolbar
        textFieldPw2.textFieldXib.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction(){
        textFieldEmail.textFieldXib.resignFirstResponder()
        textFieldPw.textFieldXib.resignFirstResponder()
        textFieldPw2.textFieldXib.resignFirstResponder()
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as? LoginViewController
        vc?.valueM = valueRole
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}

extension UIViewController{
    func alert() {
        
    }
}
