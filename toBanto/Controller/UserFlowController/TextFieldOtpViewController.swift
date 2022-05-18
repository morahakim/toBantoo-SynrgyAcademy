//
//  TextFieldOtpViewController.swift
//  toBanto
//
//  Created by Irianda on 04/11/21.
//

import UIKit
import AEOTPTextField

class TextFieldOtpViewController: UIViewController, ButtonSendDataProtocol, AEOTPTextFieldDelegate{
    
    @IBOutlet weak var btnSendOtpReapet: ButtonController!
    
    @IBOutlet weak var textFieldOtp: AEOTPTextField!
    
    var email : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Verifikasi Kode"
        self.setupHideKeyboardOnTap()
        addDoneButtonOnKeyboard()
        btnSendOtpReapet.btnXib(title: "Verifikasi")
        btnSendOtpReapet.delegate = self
        setupOTPTextField()
        
        // Do any additional setup after loading the view.
    }
    func setupOTPTextField() {
        textFieldOtp.otpDelegate = self
        textFieldOtp.otpFontSize = 16
        textFieldOtp.otpFilledBackgroundColor = #colorLiteral(red: 0.2325198054, green: 0.7697016001, blue: 0.7168982625, alpha: 1)
        textFieldOtp.otpTextColor = .white
        textFieldOtp.otpFilledBorderWidth = 0
        textFieldOtp.configure()
    }
    
    func didUserFinishEnter(the code: String) {
        
    }
    
    
    func clickButton() {
        guard textFieldOtp.text != "" else {
            let alert = UIAlertController(title: "Massage", message: "Please fill text OTP", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let otpNumber = textFieldOtp.text ?? ""
        let otpField = OtpModel(otp: otpNumber)
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
        ApiManager.shareInstance.callingOtp(otp: otpField) { (results) in
            if results {
                self.dismiss(animated: true, completion: nil)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "changepw") as? ChangePassViewController
                vc?.email = self.email
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
        
        textFieldOtp.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction(){
        textFieldOtp.resignFirstResponder()
        
    }
}


