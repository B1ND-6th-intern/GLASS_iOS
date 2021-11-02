//
//  SelectJob.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/15.
//

import UIKit
import SnapKit

class SelectJobViewController: MainURL{
    
    let mainColor = UIColor(named: "Color")
    
    private lazy var GLASSImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GLASSLogo")
        imageView.tintColor = UIColor(named: "Color")
        
        return imageView
    }()
    
    private lazy var studentButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "StudentImage"), for: .normal)
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(didTabstudentButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var parentsButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "ParentsImage"), for: .normal)
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(didTabNotStudentButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var teacherButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "TeacherImage"), for: .normal)
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(didTabNotStudentButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var ractangle: UIView = {
        let view = Ractangle()
        view.backgroundColor = mainColor
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
}

class Ractangle: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: UIScreen.main.bounds.maxY / 2))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.maxX, y: UIScreen.main.bounds.maxY / 2))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.maxX, y: UIScreen.main.bounds.maxY))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.maxY))
        
        path.fill()
        path.close()
    }
    
}

private extension SelectJobViewController{
    
    @objc func didTabstudentButton(){
        let vc = StudentsSignUpViewController()
        vc.view.backgroundColor = .systemBackground
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func didTabNotStudentButton(){
        let vc = PnTSignUpViewController()
        vc.view.backgroundColor = .systemBackground
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setup() {
        
        self.view.backgroundColor = .systemBackground
        
        let BtnStackView = UIStackView(arrangedSubviews: [studentButton, parentsButton,teacherButton])
        BtnStackView.axis = .horizontal
        BtnStackView.distribution = .fillEqually
        BtnStackView.spacing = 5
        
        [
            GLASSImageView,
            ractangle,
            BtnStackView
//            blueHalfView
            
        ] .forEach{ self.view.addSubview($0) }
        
        GLASSImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(240)
            $0.leading.equalToSuperview().offset(90)
            $0.trailing.equalToSuperview().inset(90)
            $0.bottom.equalToSuperview().inset(520)
        }
        
//        blueHalfView.snp.makeConstraints{
//            $0.leading.equalToSuperview()
//            $0.trailing.equalToSuperview()
//        }
        
        BtnStackView.snp.makeConstraints{
           $0.centerY.equalToSuperview()
            $0.top.equalTo(GLASSImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(330)
        }
        
        ractangle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.maxY / 2)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
}
