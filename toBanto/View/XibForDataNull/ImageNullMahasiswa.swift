//
//  ImageNull.swift
//  toBanto
//
//  Created by Irianda on 08/12/21.
//

import UIKit

class ImageNullMahasiswa: UIView {
    
    
    @IBOutlet weak var btnDonasiNul: UIButton!
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
        ButtonUI()
    }
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        commonInit()
        ButtonUI()
    }
    
    func commonInit() {
        let nibName = String(describing: ImageNullMahasiswa.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    func ButtonUI() {
        btnDonasiNul.layer.borderColor = #colorLiteral(red: 0.2325198054, green: 0.7697016001, blue: 0.7168982625, alpha: 1)
        btnDonasiNul.layer.borderWidth = 2
        btnDonasiNul.layer.cornerRadius = 8
    }
    
    
    
    @IBAction func btnLinkWeb(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://tobantoo-admin.herokuapp.com")! as URL)
        
    }
    
}
