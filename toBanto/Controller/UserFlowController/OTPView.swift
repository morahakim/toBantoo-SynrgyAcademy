//
//  OtpView.swift
//  toBanto
//
//  Created by mora hakim on 07/11/21.
//

import UIKit

class OTPView: UIStackView {
    
    var textFieldArray = [OTPTextField]()
    var numberOfOTPdigit = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        setTextFields()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setTextFields()
    }
    
    private func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 7
    }
    
    private func setTextFields() {
        for i in 0..<numberOfOTPdigit {
            let field = OTPTextField()
            
            textFieldArray.append(field)
            addArrangedSubview(field)
            field.delegate = self
            field.backgroundColor = .white
            field.layer.opacity = 0.5
            field.textAlignment = .center
            field.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            field.layer.shadowOpacity = 1.0
            field.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            
            i != 0 ? (field.previousTextField = textFieldArray[i-1]) : ()
            i != 0 ? (textFieldArray[i-1].nextTextFiled = textFieldArray[i]) : ()
        }
    }
}

extension OTPView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = textField as? OTPTextField else {
            return true
        }
        if !string.isEmpty {
            field.text = string
            field.resignFirstResponder()
            field.nextTextFiled?.becomeFirstResponder()
            return true
        }
        return true
    }
}

class OTPTextField: UITextField {
    var previousTextField: UITextField?
    var nextTextFiled: UITextField?
    
    override func deleteBackward() {
        text = ""
        previousTextField?.becomeFirstResponder()
    }
}

