//
//  ListHistoryTableViewCell.swift
//  toBanto
//
//  Created by Irianda on 24/11/21.
//

import UIKit
import Kingfisher

class ListHistoryTableViewCell: UITableViewCell {
    
    var camp : GetCampaignDonatur!
    
    @IBOutlet weak var imageList: UIImageView!
    
    @IBOutlet weak var labelHistory: UILabel!
    
    @IBOutlet weak var danaHistory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageList.layer.cornerRadius = 12
        imageList.clipsToBounds = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func downloadImage(url:URL) {
        imageList?.kf.setImage(with: url)
    }
}
