//
//  ProfileViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/06.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    private lazy var profileImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40.0
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserName"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요."
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()

    private lazy var EditProfileButton: UIButton = {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationItem()
        setUpLayout()
        
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell
        
        cell?.setup(with: UIImage())
        
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width / 3) - 1.0
        
        return CGSize(width: width, height: width)
    }
}

private extension ProfileViewController{
    func setUpNavigationItem() {
        navigationItem.title = "UserName"
        
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(didTabRightBarButtonItem)
        )
        navigationItem.rightBarButtonItem = rightBarButton
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
        let editProfile = UINavigationController(rootViewController: EditProfileViewController())
        present(editProfile, animated: true)
    }
    
    func setUpLayout() {
        
        let dataStackView = UIStackView(arrangedSubviews: [ studentInformationDataView, photoDataView])
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
