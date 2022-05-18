//
//  checkedView.swift
//  toBanto
//
//  Created by Irianda on 21/11/21.
//

import UIKit

class checkedView: UIView {
    
    
    @IBOutlet weak var imageCheck: UIImageView!
    
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
        let nibName = String(describing: checkedView.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
        layerView = view
        view.frame = bounds
        addSubview(view)
       
    }
    
    func image() {
        
    }
    
    

}
