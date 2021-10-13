//
//  SignInViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit

class SignInViewController: UIViewController {
    
    private lazy var idTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 15.0, weight: .medium)
        
        return textfield
    }()
    
    private lazy var passWordTextField: UITextField = {
        let textfield = UITextField()
        
        
        return textfield
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        
        
        return button
    }()
    
    private lazy var moveToSignUpButton: UIButton = {
        let button = UIButton()
        
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
}
