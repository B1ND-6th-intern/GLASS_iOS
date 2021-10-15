//
//  SignUpViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/14.
//

import UIKit
import SnapKit

class StudentsSignUpViewController: UIViewController{
    
    let mainColor = UIColor(named: "Color")
    let lightGray = UIColor(named: "Color-1")
    
    private lazy var GLASSLogoImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "GLASSLogo")
        
        return imageview
    }()
    
    private lazy var emailTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "이메일"
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        textfield.borderStyle = .roundedRect
        textfield.textColor = .label
        textfield.alpha = 0.8
        
        return textfield
    }()
    
    private lazy var passWordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "비밀번호"
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        textfield.borderStyle = .roundedRect
        textfield.textColor = .label
        textfield.alpha = 0.8
        
        return textfield
    }()
    
    private lazy var passWordCheckTextfield: UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "비밀번호 확인"
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        textfield.borderStyle = .roundedRect
        textfield.textColor = .label
        textfield.alpha = 0.8
        
        return textfield
    }()
    
    private lazy var nameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "이름"
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        textfield.borderStyle = .roundedRect
        textfield.textColor = .label
        textfield.alpha = 0.8
        
        return textfield
    }()
    
    private lazy var gradeTextfield: UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "학년"
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        textfield.textAlignment = .center
        textfield.backgroundColor  = lightGray
        textfield.borderStyle = .roundedRect
        textfield.textColor = .label
        textfield.alpha = 0.8
        
        return textfield
    }()
    
    private lazy var classTextfield: UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "반"
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        textfield.textAlignment = .center
        textfield.backgroundColor = lightGray
        textfield.borderStyle = .roundedRect
        textfield.textColor = .label
        textfield.alpha = 0.8
        
        return textfield
    }()
    
    private lazy var numberTextfield: UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "번호"
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        textfield.textAlignment = .center
        textfield.backgroundColor  = lightGray
        textfield.borderStyle = .roundedRect
        textfield.textColor = .label
        textfield.alpha = 0.8
        
        return textfield
    }()
    
    private lazy var agreeInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정도 이용 동의"
        label.font = .systemFont(ofSize: 10.0, weight: .medium)
        label.textColor = .label
        label.alpha = 0.8
        
        return label
    }()
    
    private lazy var agreeInformationSwitch: UISwitch = {
        let infoswitch = UISwitch()
        infoswitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        return infoswitch
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.backgroundColor = mainColor
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 5.0
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
}

private extension StudentsSignUpViewController{
    func setup() {
        
        let imformationStackView = UIStackView(arrangedSubviews: [gradeTextfield, classTextfield, numberTextfield])
        imformationStackView.axis = .horizontal
        imformationStackView.spacing = 10.0
        imformationStackView.distribution = .fillEqually
        imformationStackView.alignment = .center
        
        let agreeImformationStackView = UIStackView(arrangedSubviews: [agreeInformationLabel, agreeInformationSwitch])
        agreeImformationStackView.axis = .horizontal
        agreeImformationStackView.spacing = 3.0
        agreeImformationStackView.alignment = .center
        
        [
            GLASSLogoImageView,
            emailTextfield,
            passWordTextfield,
            passWordCheckTextfield,
            nameTextfield,
            imformationStackView,
            agreeImformationStackView,
            signUpButton
        ].forEach{ self.view.addSubview($0) }
        
        let textFieldSet: CGFloat = 35.0
        let inputsSet: CGFloat = 50.0
        let logoOffset: CGFloat = 90.0
        
        GLASSLogoImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(90)
            $0.leading.equalToSuperview().offset(logoOffset)
            $0.trailing.equalToSuperview().inset(logoOffset)
            $0.bottom.equalTo(emailTextfield.snp.top).offset(-80)
        }
        
        emailTextfield.snp.makeConstraints{
//            $0.top.equalTo(GLASSLogoImageView.snp.bottom).offset(inputsSet)
            $0.top.equalToSuperview().offset(220)
            $0.leading.equalToSuperview().offset(textFieldSet)
            $0.trailing.equalToSuperview().inset(textFieldSet)
        }
        
        passWordTextfield.snp.makeConstraints{
            $0.top.equalTo(emailTextfield.snp.bottom).offset(inputsSet)
            $0.leading.equalTo(emailTextfield.snp.leading)
            $0.trailing.equalTo(emailTextfield.snp.trailing)
        }
        
        passWordCheckTextfield.snp.makeConstraints{
            $0.top.equalTo(passWordTextfield.snp.bottom).offset(inputsSet)
            $0.leading.equalTo(passWordTextfield.snp.leading)
            $0.trailing.equalTo(passWordTextfield.snp.trailing)
        }
        
        nameTextfield.snp.makeConstraints{
            $0.top.equalTo(passWordCheckTextfield.snp.bottom).offset(inputsSet)
            $0.leading.equalTo(passWordCheckTextfield.snp.leading)
            $0.trailing.equalTo(passWordCheckTextfield.snp.trailing)
        }
        
        imformationStackView.snp.makeConstraints{
            $0.top.equalTo(nameTextfield.snp.bottom).offset(17)
            $0.leading.equalTo(nameTextfield.snp.leading).inset(45)
            $0.trailing.equalTo(nameTextfield.snp.trailing).inset(45)
        }
        
        agreeImformationStackView.snp.makeConstraints{
            $0.top.equalTo(imformationStackView.snp.bottom).offset(80)
            $0.leading.equalTo(nameTextfield.snp.leading)
        }
        
        let signUpButtonSet: CGFloat = 120
        
        signUpButton.snp.makeConstraints{
            $0.top.equalTo(agreeImformationStackView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(view.snp.leading).offset(signUpButtonSet)
            $0.trailing.equalTo(view.snp.trailing).inset(signUpButtonSet)
        }
        
    }
    
}
