//
//  HomeViewController.swift
//  toBanto
//
//  Created by Irianda on 11/11/21.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var labelEmail: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var email : String!
    
    var data : [Table] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.cornerRadius = imageProfile.bounds.width / 2
        self.tableView.rowHeight = 52;
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        data.append(Table(image: UIImage(named: "personTable")!, label: "Ubah Profile"))
        data.append(Table(image: UIImage(named: "lock")!, label: "Ubah Password"))
        data.append(Table(image: UIImage(named: "logout")!, label: "Keluar"))
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.setUp(image: data[indexPath.row].image, label: data[indexPath.row].label)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.selectedPost(index: 0)
        if indexPath.row == 0 {
            print("indexPath\(indexPath)")
            
            if let myProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "changeProfile") as? ChangeProfileViewController{
                self.navigationController?.pushViewController(myProfileVC, animated: true)
            }
        }
        if indexPath.row == 1{
            
            print("indexPath\(indexPath)")
            if let myProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "changeNewPw") as? ChangePWViewController{
                self.navigationController?.pushViewController(myProfileVC, animated: true)
            }
        }
        if indexPath.row == 2{
            self.hidesBottomBarWhenPushed = true
            navigationController?.navigationBar.isHidden = false
            print("indexPath\(indexPath)")
            if let myProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "view") as? ViewController
            {
                self.navigationController?.pushViewController(myProfileVC, animated: true)
            }
        }
    }
}



class Table{
    var  image: UIImage!
    var  label:  String!
    
    
    init(image: UIImage, label:String) {
        self.image = image
        self.label = label
        
    }
}

