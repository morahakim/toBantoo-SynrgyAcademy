//
//  ChangeProfileViewController.swift
//  toBanto
//
//  Created by mora hakim on 17/11/21.
//

import UIKit

class ChangeProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var namaLengkapTextField: TextFieldController!
    @IBOutlet weak var namaInstansiTextField: TextFieldController!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageBackground: UIImageView!
    
    @IBOutlet weak var btnSimpan: ButtonController!
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ubah Profile"
        namaLengkapTextField.borderBottom(rightImage: UIImage(), placeholder: "Nama Lengkap")
        namaInstansiTextField.borderBottom(rightImage: UIImage(), placeholder: "Nama Instansi")
        btnSimpan.btnXib(title: "Simpan")
        imagePicker.delegate = self
        
        //Gambar Bulat
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        
        // membuat gesture tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChangeProfileViewController.imageTapped(gesture:)))
        
        // tambahkan ke tampilan gambar
        imageView.addGestureRecognizer(tapGesture)
        // pastikan imageView dapat berinteraksi dengan pengguna
        imageView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // jika tampilan yang diclick adalah UIImageView maka atur ke image
        if let imageView = gesture.view as? UIImageView {
            print("Image Tapped")
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            
            present(imagePicker, animated: true, completion: nil)
            
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage]as? UIImage{
            imageView.contentMode = .scaleAspectFill
            imageView.image = pickedImage
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnChangeProfile(_ sender: Any) {
    }
    
}
