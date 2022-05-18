//
//  ImageNullDonatur.swift
//  toBanto
//
//  Created by Irianda on 08/12/21.
//

import UIKit

class ImageNullDonatur: UIView {
    
    @IBOutlet weak var btnDonatur: UIButton!
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        commonInit()
        ButtonUI()
    }
    
    func commonInit() {
        let nibName = String(describing: ImageNullDonatur.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    func ButtonUI() {
        btnDonatur.layer.borderColor = #colorLiteral(red: 0.2325198054, green: 0.7697016001, blue: 0.7168982625, alpha: 1)
        btnDonatur.layer.borderWidth = 2
        btnDonatur.layer.cornerRadius = 8
    }
    
    @IBAction func btnDonasiDonatur(_ sender: Any) {
        
    }
    
    
}
