//
//  ProfileViewControllerCell.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/12.
//

import UIKit
import SnapKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    func setup(with image: UIImage){
        addSubview(imageView)
        imageView.snp.makeConstraints{ $0.edges.equalToSuperview() }
        imageView.backgroundColor = .tertiaryLabel
    }
}
