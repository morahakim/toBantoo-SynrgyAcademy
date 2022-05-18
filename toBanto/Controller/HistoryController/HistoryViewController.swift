//
//  HistoryViewController.swift
//  toBanto
//
//  Created by Irianda on 24/11/21.
//

import UIKit
import Kingfisher

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightOfTableHistory: NSLayoutConstraint!
    
    @IBOutlet weak var imageNullDonatur: ImageNullDonatur!
    
    
    var history : [DataTableHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "history")
        getDataTable()
        
        // Do any additional setup after loading the view.
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
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let camp = history[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "history") as! ListHistoryTableViewCell
        if let url = URL(string: camp.project.projectImg ?? "enigmatic-wave-05196.herokuapp.com/showFile/project.jpeg"){
            cell.downloadImage(url: url)
            print(url)
        }
        cell.labelHistory.text = camp.project.projectName
        cell.danaHistory.text = "\(camp.totalDonate ?? 0)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func getDataTable(){
        ApiManager.shareInstance.callingGetHistoryCampaign { (result) in
            guard let result = result else {
                return
            }
            self.history = result.data
            if result.data.count != 0{
                self.tableView.isHidden = false
                self.imageNullDonatur.isHidden = true
            }else{
                self.imageNullDonatur.isHidden = false
                self.tableView.isHidden = true
            }
            self.tableView.reloadData()
            
        }
    }
}

