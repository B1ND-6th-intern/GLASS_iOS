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
        label.text = "999"
        
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = 서버에서 받은 사진
        imageView.backgroundColor = .tertiaryLabel
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "대소고에서의 삷이란..."  //서버에서 받은 타이틀
        
        return label
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.5, weight: .thin)
        label.textColor = .systemBlue
        label.text = "#낭만 #대소고라이프"  //서버에서 받은 태그
        
        return label
    }()
    
    private lazy var studentInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "1206 김상은"  //서버에서 받은 학번이름
        label.font = .systemFont(ofSize: 13.5, weight: .medium)
        
        return label
    }()
    
    func setup(){
        
        let likeStackView = UIStackView(arrangedSubviews: [likeButton, likeButtonCount])
        likeStackView.axis = .vertical
        likeStackView.spacing = 0
        likeStackView.alignment = .center
        
        let commentStackView = UIStackView(arrangedSubviews: [titleLabel, tagLabel])
        commentStackView.axis = .vertical
        commentStackView.spacing = 10
        commentStackView.alignment = .leading
        
        [
            likeStackView,
            postImageView,
            commentStackView,
            studentInformationLabel
        ].forEach{ addSubview($0) }
        
        let likeButtonSet: CGFloat = 17.0
        
        likeStackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(likeButtonSet)
            $0.bottom.equalToSuperview().offset(-likeButtonSet)
            $0.leading.equalToSuperview().offset(likeButtonSet)
        }
        
        postImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(likeStackView.snp.trailing).offset(25)
            $0.bottom.equalToSuperview().offset(-15)
            $0.width.equalTo(80.0)
            $0.height.equalTo(80.0)
        }
        
        commentStackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(postImageView.snp.trailing).offset(15)
        }
        
        studentInformationLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(70)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(postImageView.snp.trailing).offset(130)
        }
        
    }
    
}
