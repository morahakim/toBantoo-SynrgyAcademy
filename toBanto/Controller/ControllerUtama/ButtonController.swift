//
//  ButtonController.swift
//  toBanto
//
//  Created by Irianda on 30/10/21.
//

import UIKit

class ButtonController: UIView, UITextFieldDelegate, UINavigationControllerDelegate {
    
    var delegate: ButtonSendDataProtocol!
    
    @IBOutlet weak var Button: UIButton!
    
    var layerView :UIView!
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let nibName = String(describing: ButtonController.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
        layerView = view
        view.frame = bounds
        addSubview(view)
        self.backgroundColor = .clear
        Button.addTarget(self, action: #selector(targetButton), for: .touchUpInside)
    }
    
    @objc func targetButton() {
        delegate.clickButton()
    }
    
    
    func btnXib(title:String)  {
        Button.setTitle(title, for: .normal)
        Button.layer.cornerRadius = 10
    }
}

protocol ButtonSendDataProtocol {
    func clickButton()
}
