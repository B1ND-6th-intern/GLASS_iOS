//
//  FeedTableViewCell.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit

final class FeedTableViewCell: UITableViewCell{
    
    private lazy var postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.backgroundColor = .tertiaryLabel
        
        return postImageView
    }()
    
    private lazy var likeButton: UIButton = {
        let likeButton = UIButton()
//        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(systemName: "heart")
        
        return likeButton
    }()
    
    private lazy var commentButton: UIButton = {
        let commentButton = UIButton()
//        commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        commentButton.setImage(systemName: "message")
        
        return commentButton
    }()
    
    private lazy var directMessageButton: UIButton = {
        let directMessageButton = UIButton()
//        directMessageButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        directMessageButton.setImage(systemName: "paperplane")
        
        return directMessageButton
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let bookmarkButton = UIButton()
//        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.setImage(systemName: "bookmark")
        
        return bookmarkButton
    }()
    
    private lazy var currentLikedCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        label.numberOfLines = 5
        label.text = "홍길동님 외 999명이 좋아합니다."
        
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.text = "이 글은 Outstargram을 테스트 하는 글로 이 label안에 있는 글은 5줄 까지 되고요 또 이 안에 있는 글은 contentsLabel로써 글을 제목(?)을 나타내는 글 입니다."
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11.0, weight: .medium)
        label.text = "1일 전"
        
        return label
    }()
    
    func setup(){
        [
            postImageView,
            likeButton,
            commentButton,
            directMessageButton,
            bookmarkButton,
            currentLikedCountLabel,
            contentsLabel,
            dateLabel
        ].forEach{ addSubview($0) }
        
        postImageView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
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
        
        commentButton.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.trailing).offset(12.0)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        directMessageButton.snp.makeConstraints{
            $0.leading.equalTo(commentButton.snp.trailing).offset(12.0)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        bookmarkButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        
        currentLikedCountLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(likeButton.snp.bottom).offset(14.0)
        }
        
        contentsLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(currentLikedCountLabel.snp.bottom).offset(8.0)

        }
        
        dateLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
    
}
