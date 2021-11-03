//
//  FeedViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit
import Alamofire

class FeedViewController: MainURL {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        
        return tableView
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        return imagePickerController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()

    }
}

extension FeedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell
        cell?.selectionStyle = .none
        cell?.setup()
        
        return cell ?? UITableViewCell()
    }
}

extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectImage = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImage = originalImage
        }
        
        picker.dismiss(animated: true) { [weak self] in
            let uploadViewContoller = UploadViewContoller(uploadImage: selectImage ?? UIImage())
            let navigationContoller = UINavigationController(rootViewController: uploadViewContoller)
            navigationContoller.modalPresentationStyle = .fullScreen
            
            self?.present(navigationContoller, animated: true)
        }
    }
}

private extension FeedViewController {
    
    func setupNavigationBar() {
        navigationItem.title  = "GLASS"
        
        let uploadButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: #selector(didTabUploadButton)
        )
        
        
        let logobutton = UIBarButtonItem(
            image: UIImage(named: "GLASS_Small"),
            style: .plain,
            target: nil,
            action: nil//#selector(didTabLogoButton)
        )
        logobutton.tintColor = UIColor(named: "Color")
        logobutton.width = 20
        
        navigationItem.leftBarButtonItem = logobutton
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    @objc func didTabUploadButton() {
        present(imagePickerController, animated: true)
    }
    
//    @objc func didTabLogoButton() {
//
//        let getPostUrl = "\(super.MainURL)"
//        var dataSource: [Contact] = []
//
//        var request = URLRequest(url: URL(string: getPostUrl)!)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.timeoutInterval = 10
//
//        AF.request(request).responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                print("POST 성공")
//
//                do {
//                    let result = try JSONDecoder().decode(Writings.self, from: data)
//
//                    self.tableView.dataSource = result.contacts
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }catch(let err){
//                    print(err?.localizedDescription)
//                }
//
//
//            case .failure(let error):
//                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
//            }
//        }
//
//    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview()}
    }
}
