//
//  EditProfileViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/19.
//

import UIKit
import PhotosUI
import SnapKit
import Alamofire
import Kingfisher
import KeychainAccess

class EditProfileViewController: MainURL{
    
    fileprivate let keychain = Keychain(service: "B1ND-6th.GLASS-iOS")
    var ProfileInfo: User = User()

    private lazy var ProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        imageView.clipsToBounds = true
        
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
        textfield.placeholder = "???" // 서버에서 받은 userName
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
        textfield.placeholder = "안녕하세요 ?학년 ?반 ???입니다."
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
        
        setupView()
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
    func getToken() -> String? {
        guard let token = try? self.keychain.getString("token") else { return nil }
        return token
    }
    
    @objc func didTabeditProfileImageButton(){
        present(imagePickerController, animated: true)
    }
    
    @objc func didTabDoneButton(){
        self.dismiss(animated: true)
        
//        let Profileimg = ProfileImageView.image
        
        //서버로 바뀐 이름, 소개, 프로필, 이미지 값 보내주기
        let userInfoUrl = "\(super.MainURL)/users/edit"
        var request = URLRequest(url: URL(string: userInfoUrl)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization":("Bearer \(self.getToken()!)") ?? ""]
        request.timeoutInterval = 10

        let name = editNameTextField.text
        let introduce = editIntroduceTextField.text

        let params = [
            "name":"\(name!)",
            "introduction":"\(introduce!)"
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
                let result = try? decoder.decode(EditProfile.self, from: data)

                print(data)

            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
        
        
//        let userImagUrl = "\(super.MainURL)/users/edit/avatar"
//        var request1 = URLRequest(url: URL(string: userImagUrl)!)
//        request1.headers = ["Authorization":("Bearer \(self.getToken()!)") ?? ""]
//        request1.httpMethod = "POST"
//        request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request1.timeoutInterval = 10
//
//        let params1 = ["img":"\(ProfileImageView.image)"] as Dictionary
//
//        do {
//            try request1.httpBody = JSONSerialization.data(withJSONObject: params1, options: [])
//        } catch{
//            print("http Body Error")
//        }
//        AF.request(request1).responseData { (response1) in
//            switch response1.result{
//            case .success(let data12):
//                print("POST 성공")
//                let decoder1 = JSONDecoder()
//                let result1 = try? decoder1.decode(EditImage.self, from: data12)
//
//                print(data12)
//            case .failure(let error):
//                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
//            }
//        }
        
        let userImagUrl = "\(super.MainURL)/users/edit/avatar"
        let headers1: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Authorization": ("Bearer \(getToken()!)") ?? ""
        ]
        let data = ProfileImageView.image!.jpegData(compressionQuality: 1)!
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "img", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: userImagUrl, headers: headers1)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("POST 성공")
                    let decoder = JSONDecoder()
                    let result = try? decoder.decode(EditProfile.self, from: data)
                    
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                    self.dismiss(animated: true)
                }
                
                
            }
        
        
    }
    
    func setupView(){
        
        self.editNameTextField.placeholder = ProfileInfo.user.name
        self.editIntroduceTextField.placeholder = ProfileInfo.user.introduction
        let ProfileImg = URL(string: "\(super.MainURL)/uploads\(self.ProfileInfo.user.avatar)")
        ProfileImageView.kf.setImage(with: ProfileImg, placeholder: UIImage(named: "userImage"))
        
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
