//
//  PopularTableViewCell.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/18.
//

import UIKit
import SnapKit

final class PopularTableViewCell: UITableViewCell{
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "heart")
        
        return button
    }()
    
    private lazy var likeButtonCount: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = 서버에서 받은 사진
        postImageView.backgroundColor = .tertiaryLabel
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "대소고에서의 삷이란.."  //서버에서 받은 타이틀
        
        return label
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.text = "#낭만 #대소고라이프"  //서버에서 받은 태그
        
        return label
    }()
    
    private lazy var studentInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "1206 김상은"  //서버에서 받은 학번이름
        
        return label
    }()
    
    func setup(){
        
        [
            likeButton,
            likeButtonCount,
            postImageView,
            titleLabel,
            tagLabel,
            studentInformationLabel
        ].forEach{ addSubview($0) }
        
        let likeButtonSet: CGFloat = 30
        
        likeButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(likeButtonSet)
            $0.leading.equalToSuperview().offset(likeButtonSet)
        }
        
        likeButtonCount.snp.makeConstraints{
            $0.top.equalTo(likeButton.snp.bottom).offset(5)
            $0.leading.equalTo(likeButton.snp.trailing)
        }
        
        postImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(likeButton.snp.trailing).offset(20)
        }
        
    }
    
}
