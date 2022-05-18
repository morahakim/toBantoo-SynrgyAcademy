//
//  PaymentViewController.swift
//  toBanto
//
//  Created by Irianda on 21/11/21.
//

import UIKit

class PaymentViewController: UIViewController, ButtonSendDataProtocol {
    
    
    @IBOutlet weak var textFieldDana: DanaView!
    
    @IBOutlet weak var option1: PaymentView!
    
    @IBOutlet weak var option2: PaymentView!
    
    @IBOutlet weak var option3: PaymentView!
    
    @IBOutlet private  var multipleBtn: [UIButton]!{
        didSet{
            multipleBtn.forEach { (button) in
                button.setImage(UIImage(named:"circle"), for: .normal)
                button.setImage(UIImage(named:"radioon"), for: .selected)
            }
        }
    }
    
    @IBOutlet weak var btnSendMoney: ButtonController!
    
    var options : [String]  {
           var view = [option1,option2,option3]
           return view.map({
               $0?.namaPayment.text ?? ""
           })
       }
       
       var valuePayment : Int!
       
       var paymentMethod : String! = "BCA"
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           title = "Metode Pembayaran"
        textFieldDana.borderCurency(rightImage: UIImage(), placeholder: "")

           option1.image(image: UIImage(named: "alfamart")!, paymentMethod: "Alfamart", deksripsi: "Langsung setor dicabang")
           option2.image(image: UIImage(named: "bca")!, paymentMethod: "BCA", deksripsi: "Layanan cepat, tersedia 24 jam")
           option3.image(image: UIImage(named: "gopay")!, paymentMethod: "Gopay", deksripsi: "Bayar mudah dan cepat")
           
           // Do any additional setup after loading the view.
           btnSendMoney.btnXib(title: "Bayar")
           btnSendMoney.delegate = self
           textFieldDana.textField.keyboardType = .asciiCapableNumberPad
           self.setupHideKeyboardOnTap()
       }
       
       override func viewWillAppear(_ animated: Bool) {
             navigationController?.navigationBar.isHidden = false
             super.viewWillAppear(animated)
             self.tabBarController?.tabBar.isHidden = true
         }
       
       func clickButton() {
           
           guard textFieldDana.textField.text != "" else {
               textFieldDana.txtlbl.text = "Nominal"
               textFieldDana.txtlbl.textColor = .red
               textFieldDana.viewField.backgroundColor = .red
               return
           }
           
           let totalDonate = textFieldDana.textField.text?.curencyNoRp() ?? ""
           let paymentName =  options[valuePayment]
           
           let payment = GetPaymentModel(totalDonate: totalDonate, paymentMethod: paymentName)
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
           ApiManager.shareInstance.callingPayment(payment: payment) { (succes) in
            DispatchQueue.main.async {
                if succes {
                    self.dismiss(animated: true, completion: nil)
                     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "waiting") as? WaitingPaymentViewController
                    
                        self.navigationController?.pushViewController(vc!, animated: true)
                }
              }
           }
       }
       
       @IBAction private func multipleBtn(_ sender: UIButton) {
           uncheck()
           sender.checkboxAnimation {
               print(self.options)
               print(sender.tag)
       }
           valuePayment = sender.tag
   }
           
       func uncheck(){
           multipleBtn.forEach { (button) in
               button.isSelected = false
           }
       }
   }

   extension UIButton {
       //MARK:- Animate check mark
       func checkboxAnimation(closure: @escaping () -> Void){
           guard let image = self.imageView else {return}
           self.adjustsImageWhenHighlighted = false
           self.isHighlighted = false
           
           UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
               image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
               
           }) { (success) in
               UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                   self.isSelected = !self.isSelected
                   //to-do
                   closure()
                   image.transform = .identity
               }, completion: nil)
           }
           
       }
   }

