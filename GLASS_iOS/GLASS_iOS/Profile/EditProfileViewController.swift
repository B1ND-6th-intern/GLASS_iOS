//
//  EditProfileViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/19.
//

import UIKit
import PhotosUI
import SnapKit

class EditProfileViewController: UIViewController{

    private lazy var ProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        
        return imageView
    }()
    
    private lazy var editProfileImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 사진 변경", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(didTabeditProfileImageButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var editNameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        return label
    }()
    
    private lazy var editNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "김상은" // 서버에서 받은 userName
        textfield.borderStyle = .none
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        return textfield
    }()
    
    private lazy var editIntroduceLabel: UILabel = {
        let label = UILabel()
        label.text = "소개"
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        return label
    }()
    
    private lazy var editIntroduceTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "안녕하세요 1학년 2반 김상은입니다." // 서버에서 받은 Introduce
        textfield.borderStyle = .none
        textfield.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        return textfield
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        button.backgroundColor = UIColor(named: "Color")
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(didTabDoneButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        return imagePickerController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImage: UIImage? = nil
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectImage = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImage = originalImage
        }
        
        self.ProfileImageView.image = selectImage
        
        picker.dismiss(animated: true)
    }
}

private extension EditProfileViewController {
    
    @objc func didTabeditProfileImageButton(){
        present(imagePickerController, animated: true)
    }
    
    @objc func didTabDoneButton(){
        self.dismiss(animated: true)
        
        //서버로 값 보내주기
        
    }
    
    func setup(){
        
        self.view.backgroundColor = .systemBackground
        
        let labelsStackView = UIStackView(arrangedSubviews: [editNameLabel, editIntroduceLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 10
        labelsStackView.distribution = .fillEqually
    
        let textFieldsStackView = UIStackView(arrangedSubviews: [editNameTextField, editIntroduceTextField])
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = 10
        textFieldsStackView.distribution = .fillEqually
        
        [
            ProfileImageView,
            editProfileImageButton,
            labelsStackView,
            textFieldsStackView,
            doneButton
        ].forEach{ self.view.addSubview($0) }
        
        let profileImageSize = 80
        
        ProfileImageView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(75)
            $0.width.equalTo(profileImageSize)
            $0.height.equalTo(profileImageSize)
        }
        
        editProfileImageButton.snp.makeConstraints{
            $0.top.equalTo(ProfileImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(ProfileImageView.snp.leading).offset(-30)
            $0.trailing.equalTo(ProfileImageView.snp.trailing).offset(30)
            $0.height.equalTo(20)
        }
        
        labelsStackView.snp.makeConstraints{
            $0.top.equalTo(editProfileImageButton.snp.bottom).offset(20 * 3.5)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(editProfileImageButton.snp.leading)
            $0.height.equalTo(100)
        }
        
        textFieldsStackView.snp.makeConstraints{
            $0.top.equalTo(labelsStackView.snp.top)
            $0.leading.equalTo(labelsStackView.snp.trailing)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(labelsStackView.snp.bottom)
        }
        
        doneButton.snp.makeConstraints{
            $0.top.equalTo(textFieldsStackView.snp.bottom).offset(50)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo(40)
            $0.height.equalTo(30)
        }
    
    }
}
