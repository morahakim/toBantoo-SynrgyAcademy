//
//  KebijakanController.swift
//  toBanto
//
//  Created by Irianda on 30/10/21.
//

import UIKit

class KebijakanController: UIView {
    
    override init(frame:CGRect){
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let nibName = String(describing: KebijakanController.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    
}
