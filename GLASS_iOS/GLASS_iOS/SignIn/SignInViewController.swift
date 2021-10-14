//
//  SignInViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit

class SignInViewController: UIViewController {
    
    private lazy var GlassImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        
        return imageView
    }()
    
    private lazy var idTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 15.0, weight: .medium)
        textfield.placeholder = "이메일                                           "
        textfield.tintColor = .systemBlue
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    private lazy var passWordTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 15.0, weight: .medium)
        textfield.placeholder = "비밀번호                                        "
        textfield.tintColor = .systemBlue
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("      로그인      ", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(red: 100.0, green: 149.0, blue: 255.0, alpha: 1)
        
        return button
    }()
    
    private lazy var moveToSignUpButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    
    func setup(){
        
        let stackView = UIStackView(arrangedSubviews: [idTextField, passWordTextField])
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
            
        [
            GlassImageView,
            stackView,
            signInButton,
            moveToSignUpButton
        ].forEach{ self.view.addSubview($0) }
        
        GlassImageView.snp.makeConstraints{
            $0.centerX.equalTo(view.snp.centerX)
            
        }
        
        self.idTextField.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        stackView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
     
        signInButton.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
}
