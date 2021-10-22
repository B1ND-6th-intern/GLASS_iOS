//
//  GetEmailViewContoller.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/21.
//

import UIKit
import SnapKit

class GetEmailViewContoller: UIViewController{
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일의 인증번호를\n확인해 주세요!"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(named: "Color")
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var checkNumberTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.layer.cornerRadius = 10
        textfield.placeholder = "인증번호 4자리"
        textfield.layer.borderColor = UIColor.systemBlue.cgColor
        textfield.layer.borderWidth = 1
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        textfield.textAlignment = .center
        
        return textfield
    }()
    
    private lazy var resendButton: UIButton = {
        let button = UIButton()
        button.setTitle("재전송", for: .normal)
        button.setTitleColor(UIColor(named: "Color"), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        return button
    }()
    
    private lazy var checkAuthrizationButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = UIColor(named: "Color")
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTabcheckAuthrizationButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


private extension GetEmailViewContoller{
    
    @objc func didTabcheckAuthrizationButton() {
        //서버에 입력값을 보내주고 돌아온 값이 true일 때
//        navigationController?.popToRootViewController(animated: true)
        // false일 때
        // 틀렸다는 토스트 메세지 띄워주기
        showToast(message: "틀린 인증번호 입니다.", font: UIFont.systemFont(ofSize: 12.5, weight: .medium))
    }
    
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(
            frame: CGRect(
                x: self.view.frame.size.width / 2 - 65,
                y: self.view.frame.size.height - 100,
                width: 140, height: 30
                )
            )
        toastLabel.backgroundColor = UIColor(named: "Color")
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func setup(){
        
        [
            titleLabel,
            checkNumberTextField,
            resendButton,
            checkAuthrizationButton
        ].forEach{ self.view.addSubview($0) }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
        }
        
        checkNumberTextField.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-18)
            $0.width.equalTo(225)
            $0.height.equalTo(40)
        }
        
        resendButton.snp.makeConstraints{
            $0.centerX.equalTo(checkNumberTextField.snp.centerX)
            $0.top.equalTo(checkNumberTextField.snp.bottom).offset(20)
        }
        
        checkAuthrizationButton.snp.makeConstraints{
            $0.centerX.equalTo(resendButton.snp.centerX)
            $0.top.equalTo(resendButton.snp.bottom).offset(50)
            $0.width.equalTo(checkNumberTextField.snp.width).offset(-50)
            $0.height.equalTo(30)
        }
        
    }
}
