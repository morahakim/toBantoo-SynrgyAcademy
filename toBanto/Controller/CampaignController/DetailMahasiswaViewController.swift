//
//  DetailMahasiswaViewController.swift
//  toBanto
//
//  Created by Irianda on 20/12/21.
//

import UIKit

class DetailMahasiswaViewController: UIViewController, ButtonSendDataProtocol {
    
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
        btnDetail.btnXib(title: "Ambil Dana")
        
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
        

        // Do any additional setup after loading the view.
    }
    
    func clickButton() {
        if let myProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "payment") as? PaymentViewController{
            self.navigationController?.pushViewController(myProfileVC, animated: true)
        }
    }
    

}
