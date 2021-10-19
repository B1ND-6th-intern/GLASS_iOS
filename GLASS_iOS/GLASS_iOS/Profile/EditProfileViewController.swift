//
//  EditProfileViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/19.
//

import UIKit
import PhotosUI
import SnapKit

class EditProfileViewController: UIViewController {
    
    
    private lazy var editProfileImageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.quaternaryLabel.cgColor
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

fileprivate extension EditProfileViewController {
    
    private func showPicker() {
       let configuration = PHPickerConfiguration()
       let picker = PHPickerViewController(configuration: configuration)
       self.present(picker, animated: true, completion: nil)
    }
    
}
