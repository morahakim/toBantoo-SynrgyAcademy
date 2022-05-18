//
//  ListTableViewCell.swift
//  toBanto
//
//  Created by Irianda on 19/11/21.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    var camp: GetCampaignHome!
    
    @IBOutlet weak var imageList: UIImageView!
    
    @IBOutlet weak var labelList: UILabel!
    
    @IBOutlet weak var viewList: UIView!
    
    @IBOutlet weak var kategoriList: UILabel!
    
    @IBOutlet weak var progressViewDana: UIProgressView!
    
    @IBOutlet weak var danaTerkumpul: UILabel!
    
    @IBOutlet weak var sisaHariList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageList.layer.cornerRadius = 12
        imageList.clipsToBounds = true
        
        //radius view
        viewList.clipsToBounds = true
        viewList.layer.cornerRadius = 8
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func downloadImage(url:URL) {
        imageList?.kf.setImage(with: url)
    }
}
