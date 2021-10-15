//
//  SelectJob.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/15.
//

import UIKit
import SnapKit

class SelectJobViewController: UIViewController{
    
    private lazy var GLASSImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GLASSLogo")
        
        return imageView
    }()
    
    private lazy var studentButton: UIButton = {
        let button = UIButton()
//        button.setImage(systemName: )
        
        return button
    }()
    private lazy var parentsButton: UIButton = {
        let button = UIButton()
//        button.setImage(systemName: )
        
        return button
    }()
    private lazy var teacherButton: UIButton = {
        let button = UIButton()
//        button.setImage(systemName: )
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension SelectJobViewController{
    
}
