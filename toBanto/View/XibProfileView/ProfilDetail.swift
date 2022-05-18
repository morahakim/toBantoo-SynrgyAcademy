//
//  ProfilDetail.swift
//  toBanto
//
//  Created by mora hakim on 26/11/21.
//

import UIKit

class ProfilDetail: UIView {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var labelName: UILabel!
  @IBOutlet weak var secondLabel: UILabel!
    
   
    
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
      let nibName = String(describing: ProfilDetail.self)
      let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! UIView
      layerView = view
      view.frame = bounds
      addSubview(view)
  }
    
    


}
