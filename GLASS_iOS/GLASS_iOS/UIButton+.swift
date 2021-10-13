//
//  UIButton+.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import UIKit

extension UIButton{
    func setImage(systemName: String){
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = .zero
        
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}
