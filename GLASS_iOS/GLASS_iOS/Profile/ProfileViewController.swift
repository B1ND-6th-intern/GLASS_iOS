//
//  ProfileViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/06.
//

import UIKit
import SnapKit
import KeychainAccess
import Alamofire
import Kingfisher

final class ProfileViewController: MainURL{
    
    fileprivate let keychain = Keychain(service: "B1ND-6th.GLASS-iOS")
    fileprivate var ProfileInfo: User = User()
    
    lazy var profileImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserName"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()

    lazy var EditProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 변경", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 3.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        button.addTarget(self, action: #selector(didTabEditProfileButton), for: .touchUpInside)
        
        return button
    }()
    
    private let studentInformationDataView = ProfileDataView(title: "학반번호", count: 1206)
    private let photoDataView = ProfileDataView(title: "게시물", count: 10)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
       
        return collectionView
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.text = "게시물"
        
        return label
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.text = "학반번호"
        
        return label
    }()
    
    private lazy var postCount: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.text = "0"
        
        return label
    }()
    private lazy var infoCount: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.text = "1206"
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationItem()
        setUpLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //id를 받아오는 GET
        let getIdUrl = "\(super.MainURL)/users/user-id"
        var request = URLRequest(url: URL(string: getIdUrl)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization":("Bearer \(getToken()!)") ?? ""]
        
        // id를 통해서 게시물들의 정보를 받아오는 GET
        var getInfoUrl = "\(super.MainURL)/users/"
        var requestInfo = URLRequest(url: URL(string: getInfoUrl)!)
        requestInfo.httpMethod = "GET"
        requestInfo.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestInfo.headers = ["Authorization":("Bearer \(getToken()!)") ?? ""]
        
        AF.request(request).responseData { (response) in
            switch response.result{
            case .success(let data):
                
                print("GET 성공")
                let decoder = JSONDecoder()
                let result = try? decoder.decode(_id.self, from: data)
                
                //----------------------------------------------------------------------------
                let userId = result?.id
                let getInfoUrl = "\(super.MainURL)/users/\(userId!)"
                var requestInfo = URLRequest(url: URL(string: getInfoUrl)!)
                requestInfo.httpMethod = "GET"
                requestInfo.setValue("application/json", forHTTPHeaderField: "Content-Type")
                requestInfo.headers = ["Authorization":("Bearer \(self.getToken()!)") ?? ""]
                    
                AF.request(requestInfo).responseData { [weak self] (responseInfo) in
                    switch responseInfo.result{
                    case .success(let dataInfo):
                        print("GET 성공")
                        let decoder = JSONDecoder()
                        let result = try? decoder.decode(User.self, from: dataInfo)
                        
                        self?.ProfileInfo = result ?? User()
                        self?.collectionView.reloadData()
                        
                        self?.setUpLayout()
                        
                    case .failure(let errorInfo):
                        print("🚫 Alamofire Request Error\nCode:\(errorInfo._code), Message: \(errorInfo.errorDescription!)")
                    }
                }
                //-----------------------------------------------------------------------------
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
        
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("sfd \(ProfileInfo.user.writings.count)")
    
        return self.ProfileInfo.user.writings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell
        
        let PostImgsUrl = URL(string: "\(super.MainURL)/uploads\(self.ProfileInfo.user.writings[indexPath.row].imgs[0])")
        cell!.imageView.kf.setImage(with: PostImgsUrl, placeholder: nil)
        
        cell?.setup(with: UIImage())
        
        return cell ?? UICollectionViewCell()
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width / 3) - 1.0
        
        return CGSize(width: width, height: width)
    }
}

private extension ProfileViewController{
    
    func getToken() -> String? {
        guard let token = try? self.keychain.getString("token") else { return nil }
        return token
    }
    
    func setUpNavigationItem() {
        
        let logobutton = UIBarButtonItem(
            image: UIImage(named: "GLASS_Small"),
            style: .plain,
            target: nil,
            action: nil
        )
        
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(didTabRightBarButtonItem)
        )
        
        logobutton.tintColor = UIColor(named: "Color")
        logobutton.width = 20
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = logobutton
    }
    
    @objc func didTabRightBarButtonItem(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        [
            UIAlertAction(title: "로그아웃", style: .destructive),
            UIAlertAction(title: "닫기", style: .cancel)
        ].forEach { actionSheet.addAction($0) }
        
        present(actionSheet, animated: true)
        
        

    }
    
    @objc func didTabEditProfileButton(){
        let view = EditProfileViewController()
        view.ProfileInfo = ProfileInfo
        let editProfile = UINavigationController(rootViewController: view)
        
        present(editProfile, animated: true)
    }
    
    func setUpLayout() {
        
        self.nameLabel.text = ProfileInfo.user.name
        self.descriptionLabel.text = ProfileInfo.user.introduction
        self.postCount.text = "\(ProfileInfo.user.writings.count)"
        self.infoCount.text = "\(ProfileInfo.user.grade)\(ProfileInfo.user.classNumber)\(ProfileInfo.user.stuNumber)"
        let profileImageUrl = URL(string: "\(super.MainURL)/uploads\(self.ProfileInfo.user.avatar)")
        profileImageView.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "userImage"))
        
        let infoStackView = UIStackView(arrangedSubviews: [infoCount, infoLabel])
        infoStackView.axis = .vertical
        infoStackView.alignment = .center
        infoStackView.spacing = 4.0
        
        let postStackView = UIStackView(arrangedSubviews: [postCount, postLabel])
        postStackView.axis = .vertical
        postStackView.alignment = .center
        postStackView.spacing = 4.0
        
        let dataStackView = UIStackView(arrangedSubviews: [ postStackView, infoStackView])
        dataStackView.spacing = 4.0
        dataStackView.distribution = .fillEqually
        
        [
            profileImageView,
            dataStackView,
            nameLabel,
            descriptionLabel,
            EditProfileButton,
            collectionView
        ].forEach{ view.addSubview($0) }
        
        let inset: CGFloat = 16.0
        profileImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.width.equalTo(80.0)
            $0.height.equalTo(profileImageView.snp.width)
        }
        
        dataStackView.snp.makeConstraints{
            $0.leading.equalTo(profileImageView.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.centerY.equalTo(profileImageView.snp.centerY)

        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(profileImageView.snp.bottom).offset(12.0)
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        EditProfileButton.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        collectionView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(EditProfileButton.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
        }
        
    }
    
}
