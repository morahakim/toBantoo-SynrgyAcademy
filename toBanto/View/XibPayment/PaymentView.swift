//
//  PaymentView.swift
//  toBanto
//
//  Created by Irianda on 21/11/21.
//

import UIKit

class PaymentView: UIView {
    
    @IBOutlet weak var imagePayment: UIImageView!
    
    @IBOutlet weak var namaPayment: UILabel!
    
    
    @IBOutlet weak var dekripsi: UILabel!
    
    
    var layerView :UIView!
    override init(frame:CGRect){
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let nibName = String(describing: PaymentView.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
        layerView = view
        view.frame = bounds
        addSubview(view)
        
    }
    
    func image(image:UIImage, paymentMethod:String, deksripsi:String)  {
        imagePayment.image = image
        namaPayment.text = paymentMethod
        dekripsi.text = deksripsi
    }
    
    
}


