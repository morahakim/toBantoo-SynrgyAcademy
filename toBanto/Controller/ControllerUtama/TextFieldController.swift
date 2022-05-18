//
//  TextFieldController.swift
//  toBanto
//
//  Created by Irianda on 29/10/21.
//

import UIKit

class TextFieldController: UIView, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textFieldXib: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var labelCenterYConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var viewField: UIView!
    
    var securedTextField = true
    
    override init(frame:CGRect){
        super.init(frame: frame)
        commonInit()
        setUpUI()
        
    }
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        commonInit()
        setUpUI()
        
    }
    
    func commonInit() {
        let nibName = String(describing: TextFieldController.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        addSubview(view)
        
    }
    
    func setUpUI() {
        textFieldXib.delegate = self
    }
    
    func borderBottom(rightImage:UIImage, placeholder:String)  {
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textFieldXib.frame.height - 1, width: textFieldXib.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        textFieldXib.borderStyle = UITextField.BorderStyle.none
        textFieldXib.layer.addSublayer(bottomLine)
        
        image.image = rightImage
        label.text = placeholder
        textFieldXib.autocorrectionType = .no
        textFieldXib.autocorrectionType = .no
    }
    
    
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.textFieldXib {
            self.textFieldXib.isHidden = false
            //            self.textFieldEmail.text = self.textFieldEmail.placeholder
            //            self.textFieldEmail.placeholder = ""
        }
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.textFieldXib {
            if self.textFieldXib.text == "" {
                //                self.textFieldEmail.text = "Email"
            }
        }
    }
    
    @objc func tapImage(_ gesture: UITapGestureRecognizer){
        securedTextField = !securedTextField
        textFieldXib.isSecureTextEntry = securedTextField
    }
    
    
    
    
    @IBAction func textDidChange(_ sender: UITextField) {
        
        if sender.text != "" {
            labelCenterYConstrain.constant = -23
            
        }else{
            labelCenterYConstrain.constant = 0
        }
        
        if sender.text != "" {
            viewField.backgroundColor = #colorLiteral(red: 0.2325198054, green: 0.7697016001, blue: 0.7168982625, alpha: 1)
        }else {
            viewField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
        if sender.text != "" {
            label.textColor = #colorLiteral(red: 0.2325198054, green: 0.7697016001, blue: 0.7168982625, alpha: 1)
        }else {
            label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    @IBAction func tapEye(_ sender: Any) {
    }
    
    
}


