//
//  LoginViewController.swift
//  toBanto
//
//  Created by mora hakim on 31/10/21.
//

import UIKit

class LoginViewController: UIViewController, ButtonSendDataProtocol {
    
    var iconClick = false
    var imageIcon = UIImageView()
    
    @IBOutlet weak var textFieldEmail: TextFieldController!
    
    @IBOutlet weak var textFieldPw: TextFieldController!
    
    @IBOutlet weak var viewKebijakan: UIView!
    
    @IBOutlet weak var btnLogin: ButtonController!
    
    var valueM : String!
        
        override func viewDidLoad() {
          super.viewDidLoad()
        
        title = "Login"
        self.setupHideKeyboardOnTap()
        addDoneButtonOnKeyboard()
        
        textFieldEmail.borderBottom(rightImage: UIImage(), placeholder: "Email")
        textFieldPw.borderBottom(rightImage: UIImage(systemName: "eye.slash")!, placeholder: "Password")
        btnLogin.btnXib(title: "Login")
        textFieldPw.textFieldXib.isSecureTextEntry = true
        btnLogin.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: true)
      }
        
        func clickButton() {
            
            guard textFieldEmail.textFieldXib.text != "" else {
                textFieldEmail.label.text = "Email"
                textFieldEmail.label.textColor = .red
                textFieldEmail.viewField.backgroundColor = .red
                return}
            
            guard textFieldPw.textFieldXib.text != "" else {
                textFieldPw.label.text = "Password"
                textFieldPw.label.textColor = .red
                textFieldPw.viewField.backgroundColor = .red
                return}
            
            let email = textFieldEmail.textFieldXib.text ?? ""
            let password = textFieldPw.textFieldXib.text ?? ""
            
            let modelLogin = LoginModel(username: email, password: password, grant_type: "password", client_id: "my-client-apps", client_secret: "password")
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
            ApiManager.shareInstance.callingLoginApi(login: modelLogin) { (result) in
              switch result {
              case .success(let json):
                print(json as AnyObject)
                guard let data = json as? Data else {return}
                var jsonDecoder = JSONDecoder()
                do {
                 var modelLogin = try jsonDecoder.decode(LoginResponseModel.self, from: data)
                  print(modelLogin.access_token)
                  UserDefaults.standard.set(modelLogin.access_token, forKey: "access_token")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: {
                            if self.valueM == "ROLE_ADMIN"{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mahasiswa") as? MahasiswaTabBarController
                                vc?.ambil = self.textFieldEmail.textFieldXib.text
                                UserDefaults.standard.set(self.textFieldEmail.textFieldXib.text, forKey:"email")
                                self.navigationController?.pushViewController(vc!, animated: true)
                            }else{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabBar") as? TabbarViewController
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                
                            }
                        
                    })
                 }
                }catch {
                  print(error)
                }
              case .failure(let err):
                print(err.localizedDescription)
              }
            }
          }
        
      //Function Tap Recognizer
      @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if iconClick {
          iconClick = false
          tappedImage.image = UIImage(systemName: "eye.slash")
            textFieldPw.securedTextField = true
        }
        else {
          iconClick = true
          tappedImage.image = UIImage(systemName: "eye")
            textFieldPw.securedTextField = false
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
            }

            @objc func doneButtonAction(){
                textFieldEmail.textFieldXib.resignFirstResponder()
                textFieldPw.textFieldXib.resignFirstResponder()
            }
    
    //Segue Programmatically
    @IBAction func lupaPasswordButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "lupaPassword") as? ForgotPwViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    //Segue Programmatically
    @IBAction func buttonDaftar(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "view") as? ViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}



