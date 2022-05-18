//
//  CampaignMahasiswaViewController.swift
//  toBanto
//
//  Created by Irianda on 24/11/21.
//

import UIKit
import Alamofire
import Kingfisher

class CampaignMahasiswaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageNullMahasiswa: ImageNullMahasiswa!
    
    
    var myCampaign : [dataDetailCampaign] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "dataList")
        
        title = "MyCampaign"
        tableView.dataSource = self
        tableView.delegate = self
        getDataTable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) { // As soon as vc disappears
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCampaign.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let camp = myCampaign[indexPath.row]
        let urlImage = URL(string: camp.projectImg ?? "")
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataList") as! ListTableViewCell
        cell.labelList.text = camp.projectName
        cell.imageList.kf.setImage(with: urlImage)
        cell.kategoriList.text = camp.category
        cell.danaTerkumpul.text = camp.budget
        cell.sisaHariList.text = "\(camp.duration ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let camp = myCampaign.count
        let dataDonatur = myCampaign[indexPath.row]
        //self.selectedPost(index: 0)
        print(camp)
        
        if let detailCampaign = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailMahasiswa") as? DetailMahasiswaViewController{
            detailCampaign.dataDonatur = dataDonatur
            self.navigationController?.pushViewController(detailCampaign, animated: true)
        }
    }
    
    
    func getDataTable(){
        ApiManager.shareInstance.callingGetMyCampaign { (result) in
            guard let result = result else {
                
                return
            }
            self.myCampaign = result.data
            if result.data.count != 0{
                self.tableView.isHidden = false
                self.imageNullMahasiswa.isHidden = true
            }else{
                self.imageNullMahasiswa.isHidden = false
                self.tableView.isHidden = true
            }
            self.tableView.reloadData()
        }
    }
    
    
    
    
    @IBAction func linkCreateCampaign(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://tobantoo-admin.herokuapp.com")! as URL)
    }
    
}


