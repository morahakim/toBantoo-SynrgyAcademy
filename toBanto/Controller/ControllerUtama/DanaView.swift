//
//  DanaView.swift
//  toBanto
//
//  Created by ADMIN on 10/12/21.
//
//
import UIKit

class DanaView: UIView {

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func Dana(_ sender: Any) {
    }

    @IBOutlet weak var viewField: UIView!
    
    @IBOutlet weak var txtlbl: UILabel!
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.currency()    }

    var numberFormatter = NumberFormatter()

    override init(frame:CGRect){
        super.init(frame: frame)
        commonInit()

    }

    required init?(coder:NSCoder){
        super.init(coder: coder)
        commonInit()

    }

    func commonInit() {
        let nibName = String(describing: DanaView.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        addSubview(view)
        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                       for: UIControl.Event.editingChanged)//namatextfiel (self.textfield)
        //
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "Rp"
        numberFormatter.maximumFractionDigits = 0

    }
    
    func borderCurency(rightImage:UIImage, placeholder:String)  {
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
        
        txtlbl.text = placeholder
        textField.autocorrectionType = .no
        textField.autocorrectionType = .no
        
        
    }
}



extension String {
    func currency() -> String {
        var string = self.replacingOccurrences(of: "Rp.", with: "").replacingOccurrences(of: ",", with: "")
        var coin = ""
        if let range = string.range(of: ".") {
            let coins = string[range.upperBound...]
            coin = "."+coins
            string.removeSubrange(range.upperBound...)
            string = string.replacingOccurrences(of: ".", with: "")
            if coin.count > 3 {
                coin = String(coin.dropLast())
                string.append(coin)
                return string
            }
        }
        if string.count > 0 {
            switch string.count {
                case 4:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 1))
                case 5:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 2))
                case 6:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 3))
                case 7:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 1))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 5))
                case 8:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 2))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 6))
                case 9:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 3))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 7))
                case 10:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 1))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 5))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 9))
                case 11:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 2))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 6))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 10))
                case 12:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 3))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 7))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 11))
                case 13:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 1))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 5))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 9))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 13))
                case 14:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 2))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 6))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 10))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 14))
                case 15:
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 3))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 7))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 11))
                    string.insert(",", at: string.index(string.startIndex, offsetBy: 15))
                default:
                    break
            }
            string.insert(contentsOf: "Rp.", at: string.startIndex)
        }
        string.append(coin)
        string = string.replacingOccurrences(of: " ", with: "")
        return string
    }
    
    func curencyNoRp() -> String {
        var string = self.replacingOccurrences(of: "Rp.", with: "").replacingOccurrences(of: ",", with: "")
        return string
    }
}
//
//import UIKit
//
//class DanaView: UIView, UITextFieldDelegate {
//
//    @IBOutlet weak var txtDigit: UITextField!
//
//    var strDigit: String = String()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        let label = UILabel(frame: CGRect(x :0,y :0,width :10,height: 10))
//        label.text = "$"
//        self.txtDigit.leftViewMode = .always
//        self.txtDigit.leftView = label
//
//        txtDigit.layer.cornerRadius = 4.0
//        txtDigit.layer.masksToBounds = true
//        txtDigit.layer.borderColor = UIColor.lightGray.cgColor
//        txtDigit.layer.borderWidth = 1.0
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return true
//    }
//
//    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if  textFieldToChange == txtDigit{
//            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
//            let compSepByCharInSet = string.components(separatedBy: aSet)
//            let numberFiltered = compSepByCharInSet.joined(separator: "")
//
//            if numberFiltered == "" {
//                let new  = txtDigit.text!
//                let fsf = new.substring(to: new.index(new.endIndex, offsetBy: -1))
//                let currentString = fsf
//                let findStr = commaStrSet(currentString: currentString)
//                txtDigit.text = findStr
//                return false
//            }
//            else{
//                let currentString = (textFieldToChange.text! as NSString)
//                    .replacingCharacters(in: range, with: string)
//                let findStr = commaStrSet(currentString: currentString)
//                txtDigit.text = findStr
//            }
//        }
//        return false
//    }
//
//    func commaStrSet(currentString: String) -> String {
//        var replaceStr = currentString.replacingOccurrences(of: ",", with: "")
//        let length = replaceStr.characters.count
//        switch length {
//        case 4:
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 1))
//        case 5:
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 2))
//        case 6:
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 1))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 5))
//        case 7:
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 2))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 5))
//        case 8:
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 1))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 4))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 7))
//        case 9:
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 2))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 5))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 8))
//        case 10:
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 1))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 4))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 7))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 10))
//        case 11,12,13,14,15:
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 1))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 4))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 7))
//            replaceStr.insert(",", at: replaceStr.index(replaceStr.startIndex, offsetBy: 10))
//        default:
//            break
//        }
//
//        return replaceStr
//    }
//}
