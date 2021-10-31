//
//  SignInViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit
import Alamofire

class SignInViewController: MainURL {
    
    let mainColor = UIColor(named: "Color")
    
    private lazy var GlassImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GLASSLogo")
        imageView.tintColor = UIColor(named: "Color")
        
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 15.0, weight: .medium)
        textfield.placeholder = "이메일"
        textfield.tintColor = .systemBlue
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        
        return textfield
    }()
    
    private lazy var passWordTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 15.0, weight: .medium)
        textfield.placeholder = "비밀번호"
        textfield.tintColor = .systemBlue
        textfield.borderStyle = .roundedRect
        textfield.isSecureTextEntry = true
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        
        return textfield
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = mainColor
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(didTabSignInButton), for: .touchUpInside)
        
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
        button.addTarget(self, action: #selector(didTabmoveToSignUpButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
}

private extension SignInViewController{
    
    @objc func didTabSignInButton() {
        let url = "\(super.MainURL)/login"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let email = emailTextField.text
        let password = passWordTextField.text
        
        let params = [
            "email":"\(email!)",
            "password":"\(password!)"
        ] as Dictionary
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseData { (response) in
            switch response.result {
            case .success(let data):
                print("POST 성공")
                let decoder = JSONDecoder()
                let result = try? decoder.decode(LogIn.self, from: data)
                dump(data)
                
                if result?.status == 200{
                    // TabBarController 띄우기
                    // 토큰은 어떻게 되는 걸까....?
                }
                
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    @objc func didTabmoveToSignUpButton() {
        let rootVC = SelectJobViewController()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func setup(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passWordTextField])
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
            $0.trailing.equalToSuperview().inset(logoOffset)
            $0.bottom.equalTo(emailTextField.snp.top).offset(-80)
        }
        
        self.emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
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

        signUpStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }
    }
}
