//
//  FeedViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit
import Alamofire
import KeychainAccess

class FeedViewController: MainURL {
    
    fileprivate let keychain = Keychain(service: "B1ND-6th.GLASS-iOS")
    fileprivate var Writings: [Writings] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let upLoadUrl = "\(super.MainURL)/posts"
        var request = URLRequest(url: URL(string: upLoadUrl)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization":("Bearer \(getToken()!)") ?? ""]
        
        AF.request(request).responseData { [weak self] (response) in
            switch response.result{
            case .success(let data):
                
                print("GET 성공")
                let decoder = JSONDecoder()
                let result = try? decoder.decode(HomeResponse.self, from: data)
                
                self?.Writings = result?.writings ?? []
                
                self?.tableView.reloadData()
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
        
    }
}

// ldh165163@gmail.com
// qwerty3907


extension FeedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Writings.count)
        return self.Writings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell
        
        // 이미지 넣어주기
        let PostImageurl = URL(string: "\(super.MainURL)/uploads\(self.Writings[indexPath.row].imgs[0])")
        cell!.postImageView.kf.setImage(with: PostImageurl, placeholder: UIImage(named: "GLASS_Small"))
        
        // profileImageView 넣어주기
//        let ProfileImageUrl = URL(string: "\(super.MainURL)/upload\(self.Writings[indexPath.row].owner.avatar)")
//        cell!.postImageView.kf.setImage(with: ProfileImageUrl, placeholder: UIImage(named: "GLASS_Small"))
        
        // userName 넣어주기
        cell!.userNameLabel.text = "\(self.Writings[indexPath.row].owner.grade)\(self.Writings[indexPath.row].owner.classNumber)\(self.Writings[indexPath.row].owner.stuNumber)  \(self.Writings[indexPath.row].owner.name)"
        
        // currentLikedCountLabel 넣어주기
        cell!.currentLikedCountLabel.text = "\(self.Writings[indexPath.row].likeCount)"
        
        // contentsLabel 넣어주기
        cell!.contentsLabel.text = "\(self.Writings[indexPath.row].text!)"
        
        // hashTagLabel 넣어주기
        cell!.hashTagLabel.text = "# \(String(describing: self.Writings[indexPath.row].hashtags[0]!))"
        
        
        
        cell?.selectionStyle = .none
        cell?.setup()
        
        return cell ?? UITableViewCell()
    }
}




extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{          // 밑에 info에서 고른 사진의 형식, 이름을 이용한다.
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
    
    func getToken() -> String? {
        guard let token = try? self.keychain.getString("token") else { return nil }
        return token
    }
    
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
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview()}
    }
}
