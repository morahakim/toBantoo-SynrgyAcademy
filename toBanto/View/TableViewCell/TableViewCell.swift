//
//  TableViewCell.swift
//  toBanto
//
//  Created by Irianda on 16/11/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageTable: UIImageView!
    
    @IBOutlet weak var labelTable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUp(image: UIImage, label:String) {
        imageTable.image = image
        labelTable.text = label
    }
    
    
    
}
