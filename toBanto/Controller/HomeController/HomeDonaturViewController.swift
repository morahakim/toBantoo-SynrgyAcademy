//
//  HomeDonaturViewController.swift
//  toBanto
//
//  Created by Irianda on 13/12/21.
//

import UIKit
import Alamofire
import Kingfisher

class HomeDonaturViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var kategoriCollection: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    
    var imgArr = [UIImage(named: "Image1"),
                  UIImage(named:"Image2"),
                  UIImage(named: "Image3")]
    
    var lblKategori: [String] = ["Biologi", "Ekonomi", "Kesehatan", "Edukasi", "Seni", "Teknik","Komputer", "Semua"]
    
    var dataCampaign: [dataDetailCampaign] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        let nibCell = UINib(nibName: "KategoriCollectionViewCell", bundle: nil)
        kategoriCollection.register(nibCell, forCellWithReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "dataList")
        kategoriCollection.delegate = self
        kategoriCollection.dataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        
        //scroll
        tableView.isScrollEnabled = false
        
        tableView.reloadData()
        print(tableView.contentSize.height)
        print(tableView.frame.height, heightOfTableView.constant)
        view.layoutIfNeeded()
        dataHomeDonatur()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCampaign.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let camp = dataCampaign[indexPath.row]
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) { // As soon as vc disappears
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func dataHomeDonatur(){
        ApiManager.shareInstance.callingCampaignDonatur { [self] (result) in
            guard let result = result else {
                return
            }
            self.dataCampaign = result.data
            self.tableView.reloadData()
            print(self.dataCampaign.count)
            heightOfTableView.constant = CGFloat(152 * self.dataCampaign.count)
        }
    }
}


extension HomeDonaturViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === kategoriCollection {
            return lblKategori.count
        }else {
            return imgArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === kategoriCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? KategoriCollectionViewCell
            var title = lblKategori[indexPath.row]
            cell?.imageKategori.image = UIImage(named: title)
            cell?.labelKategori.text = title
            return cell!
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DataCollectionViewCell
            cell?.img.image = imgArr[indexPath.row]
            return cell!
        }
    }
}

extension HomeDonaturViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        if collectionView === kategoriCollection {
            return CGSize(width: size.width, height: 5)
        }else {
            return CGSize(width: size.width, height: size.height)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView === kategoriCollection {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> CGFloat {
        if collectionView === kategoriCollection {
            return 5
        }else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView === kategoriCollection {
            return 5
        }else {
            return 0
        }
    }
}
