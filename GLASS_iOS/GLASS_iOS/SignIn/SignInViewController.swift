//
//  SignInViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit

class SignInViewController: UIViewController {
    
    let mainColor = UIColor(named: "Color")
    
    private lazy var GlassImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GLASSLogo")
        
        return imageView
    }()
    
    private lazy var idTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 15.0, weight: .medium)
        textfield.placeholder = "이메일"
        textfield.tintColor = .systemBlue
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    private lazy var passWordTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 15.0, weight: .medium)
        textfield.placeholder = "비밀번호"
        textfield.tintColor = .systemBlue
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = mainColor
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5.0
        
        return button
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 계정이 없으시다면"
        label.textColor = .label
        label.alpha = 0.6
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var moveToSignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = nil
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        button.setTitleColor(UIColor(named: "Color"), for: .normal)
        
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
        
        let signUpStackView = UIStackView(arrangedSubviews: [signUpLabel, moveToSignUpButton])
        signUpStackView.axis = .horizontal
        signUpStackView.spacing = 5.0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
            
        [
            GlassImageView,
            stackView,
            signInButton,
            signUpStackView
        ].forEach{ self.view.addSubview($0) }
        
        let logoOffset: CGFloat = 90.0
        GlassImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(235)
            $0.leading.equalToSuperview().offset(logoOffset)
            $0.trailing.equalToSuperview().offset(-logoOffset)
            $0.bottom.equalTo(idTextField.snp.top).offset(-80)
        }
        
        self.idTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
//            $0.width.equalTo(100)
        }
        self.passWordTextField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
     
        signInButton.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(100)
            $0.trailing.equalToSuperview().offset(-100)
        }
        
        let signUpStackViewOffset = 50

        signUpStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }
    }
    
}
