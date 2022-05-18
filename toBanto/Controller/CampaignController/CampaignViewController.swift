//
//  CampaignViewController.swift
//  toBanto
//
//  Created by Irianda on 20/11/21.
//

import UIKit

class CampaignViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating{
    
    @IBOutlet weak var filterCollection: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightOfTableDonatur: NSLayoutConstraint!
    
    
    let seacrh = UISearchController()
    var dataCampaignDonatur : [dataDetailCampaign] = []
    
    let listFilter = ["Filter", "Mendesak", "Trending", "Terbaru", "Terkumpul Dana Paling Sedikit"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "dataList")
        navigationItem.searchController = seacrh
        seacrh.searchResultsUpdater = self
        seacrh.obscuresBackgroundDuringPresentation = false
        
        tableView.dataSource = self
        tableView.delegate = self
        let uiNib = UINib(nibName: "KategoriCollectionViewCell", bundle: nil)
        filterCollection.register(uiNib, forCellWithReuseIdentifier: "cell")
        filterCollection.delegate = self
        filterCollection.dataSource = self
        tableView.reloadData()
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
    
    //func seacrh
    func updateSearchResults(for searchController: UISearchController) {
        var dataSearch =  searchController.searchBar.text
        ApiManager.shareInstance.callingSeacrhDonatur(text: dataSearch ?? "") { (result) in
            guard let result = result else {
                return
            }
            self.dataCampaignDonatur = result.data
            self.tableView.reloadData()
            print(self.dataCampaignDonatur.count)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCampaignDonatur.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let camp = dataCampaignDonatur[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataList") as! ListTableViewCell
        cell.labelList.text = camp.projectName
        
        if let url = URL(string: camp.projectImg ?? "enigmatic-wave-05196.herokuapp.com/showFile/project.jpeg"){
            cell.downloadImage(url: url)
            print(url)
        }
        
        cell.kategoriList.text = camp.category
        cell.danaTerkumpul.text = camp.budget
        cell.sisaHariList.text = "\(camp.duration ?? 0)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let camp = dataCampaignDonatur.count
        let dataDonatur = dataCampaignDonatur[indexPath.row]
        //self.selectedPost(index: 0)
        print(camp)
        
        if let detailCampaign = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detail") as? DetailCampaignViewController{
            detailCampaign.dataDonatur = dataDonatur
            self.navigationController?.pushViewController(detailCampaign, animated: true)
        }
    }
    
    func getDataTable(){
        ApiManager.shareInstance.callingCampaignDonatur { [self] (result) in
            guard let result = result else {
                return
            }
            self.dataCampaignDonatur = result.data
            self.tableView.reloadData()
            print(self.dataCampaignDonatur.count)
        }
    }
    
}

extension CampaignViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFilter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? KategoriCollectionViewCell
        cell?.labelKategori.text = listFilter[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1{
            var textIndex = indexPath.debugDescription
            print(indexPath.debugDescription)
            ApiManager.shareInstance.callingFilter(text:textIndex) { (result) in
                guard let result = result else {
                    return
                }
                self.dataCampaignDonatur = result.data
                self.tableView.reloadData()
                print(self.dataCampaignDonatur.count)
            }
        }
        
    }
}

extension CampaignViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


