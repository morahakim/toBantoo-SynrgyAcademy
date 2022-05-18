//
//  DetailViewController.swift
//  toBanto
//
//  Created by Irianda on 24/11/21.
//

import UIKit

class DetailCampaignViewController: UIViewController, ButtonSendDataProtocol {
    
    
    @IBOutlet weak var btnDetail: ButtonController!
    
    @IBOutlet weak var imageDetailCampaign: UIImageView!
    
    @IBOutlet weak var titleDetailCampaign: UILabel!
    
    @IBOutlet weak var totalUangLabel: UILabel!
    
    @IBOutlet weak var totalDonaturLabel: UILabel!
    
    @IBOutlet weak var rangkumanTextView: UITextView!
    
    @IBOutlet weak var detailBudgetCampaign: UILabel!
    
    @IBOutlet weak var latarBelakangCampaign: UITextView!
    
    @IBOutlet weak var goalsProjectCampaign: UITextView!
    
    @IBOutlet weak var batasWaktuLabel: UILabel!
    
    var dataDonatur: dataDetailCampaign!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail Campaign"
        btnDetail.delegate = self
        btnDetail.btnXib(title: "Donasi Sekarang!")
        
        titleDetailCampaign.text = dataDonatur.projectName
        goalsProjectCampaign.text = dataDonatur.projectGoal
        latarBelakangCampaign.text = dataDonatur.projectBackground
        rangkumanTextView.text = dataDonatur.projectSummary
        detailBudgetCampaign.text = dataDonatur.budgetDetails
        batasWaktuLabel.text = "\(dataDonatur.duration ?? 0)"
        let urlString = dataDonatur.projectImg!
        let url = URL(string: urlString)
        imageDetailCampaign.downloaded(from: url!)
        totalUangLabel.text =  "Rp." + dataDonatur.budget
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func clickButton() {
        if let myProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "payment") as? PaymentViewController{
            self.navigationController?.pushViewController(myProfileVC, animated: true)
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

