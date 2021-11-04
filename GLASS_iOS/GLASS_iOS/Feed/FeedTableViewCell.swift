//
//  FeedTableViewCell.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit
import Alamofire

final class FeedTableViewCell: UITableViewCell {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiaryLabel
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserName"
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.backgroundColor = .tertiaryLabel
        
        return postImageView
    }()
    
    private lazy var likeButton: UIButton = {
        let likeButton = UIButton(type: .system)
        likeButton.setImage(systemName: "heart")
        likeButton.addTarget(self, action: #selector(didTabLikeButton), for: .touchUpInside)
        likeButton.isEnabled = true
        
        return likeButton
    }()
    
    private lazy var currentLikedCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        label.numberOfLines = 5
        label.text = "999명이 좋아합니다."
        
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.text = "이 글은 GLASS을 테스트 하는 글로 이 label안에 있는 글은 5줄 까지 되고요 또 이 안에 있는 글은 contentsLabel로써 글을 제목(?)을 나타내는 글 입니다."
        
        return label
    }()
    
    @objc func didTabLikeButton(){
        //좋아요 색깔 바꾸기
        if likeButton.currentImage == UIImage(systemName: "heart") {
            self.likeButton.tintColor = .red
            self.likeButton.setImage(systemName: "heart.fill")
        }else{
            self.likeButton.tintColor = .black
            self.likeButton.setImage(systemName: "heart")
        }
        
    }
    
    func setup(){
        
        self.contentView.alpha = 0
        
        [
            profileImageView,
            userNameLabel,
            postImageView,
            likeButton,
            
            currentLikedCountLabel,
            contentsLabel
        ].forEach{ addSubview($0) }
        
        profileImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5.0)
            $0.leading.equalToSuperview().offset(5.0)
            $0.bottom.equalTo(postImageView.snp.top).offset(-5.0)
            $0.width.equalTo(40.0)
            $0.height.equalTo(profileImageView.snp.width)
        }
        
        userNameLabel.snp.makeConstraints{
            $0.top.equalTo(profileImageView.snp.top)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(15)
            $0.bottom.equalTo(profileImageView.snp.bottom)
        }
        
        postImageView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom)
            $0.height.equalTo(postImageView.snp.width)
        }
        
        let buttonWidth: CGFloat = 24.0
        let buttonInset: CGFloat = 16.0

        likeButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(postImageView.snp.bottom).offset(buttonInset)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        currentLikedCountLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(postImageView.snp.trailing)
            $0.top.equalTo(likeButton.snp.bottom).offset(14.0)
        }
        
        contentsLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(postImageView.snp.trailing)
            $0.top.equalTo(currentLikedCountLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview().inset(16.0)

        }
    }
    
}
