//
//  UploadViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit
import Alamofire
import Kingfisher
import KeychainAccess

final class UploadViewContoller: MainURL {
    
    fileprivate let keychain = Keychain(service: "B1ND-6th.GLASS-iOS")
    
    private let uploadImage: UIImage
    private let imageView = UIImageView()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "문구 입력..."
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15.0)
        textView.delegate = self
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        
        return textView
    }()
    
    init(uploadImage: UIImage){
        self.uploadImage = uploadImage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var hashtagTextField: UITextField = {
        let textfield = UITextField()
        textfield.textColor = .systemBlue
        textfield.placeholder = "# 를 입력하세요! (해쉬테그는 하나만 가능합니다.)"
        textfield.font = .systemFont(ofSize: 13.0, weight: .medium)
        textfield.borderStyle = .none
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setUpNavigationItem()
        setupLayout()
        
        imageView.image = uploadImage
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
}

extension UploadViewContoller: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
}

private extension UploadViewContoller {
    func setUpNavigationItem() {
        navigationItem.title = "새 게시물"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(didTabLeftButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "공유",
            style: .plain,
            target: self,
            action: #selector(didTabRightButton)
        )
    }
    
    @objc func didTabLeftButton() {
        dismiss(animated: true)
    }
    
    @objc func didTabRightButton() {
        
        let upLoadImage = uploadImage
        let data = upLoadImage.jpegData(compressionQuality: 1)!
        
        var resendImage: [String] = []
        let upLoadText = textView.text
        let upLoadHash = hashtagTextField.text
        
        
        
        // 처음 이미지만 보내주는 코드
        let uploadImageUrl = "\(super.MainURL)/writings/upload/imgs"
        let urlConvertible: Alamofire.URLConvertible = uploadImageUrl
        
            let headers1: HTTPHeaders = [
                "Content-type": "multipart/form-data",
                "Authorization": ("Bearer \(getToken()!)") ?? ""
            ]
            
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "img", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: uploadImageUrl, headers: headers1)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("POST 성공")
                    let decoder = JSONDecoder()
                    let result: ImagePost? = try? decoder.decode(ImagePost.self, from: data)
                    
                    if result?.status == 200 {
                        resendImage = (result?.jsonUrl) ?? []
                        
                //         이미지와 글, 해쉬태그 보내주는 코드
                        let upLoadUrl = "\(super.MainURL)/writings/upload"
                        var request = URLRequest(url: URL(string: upLoadUrl)!)
                        request.httpMethod = "POST"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.headers = ["Authorization":("Bearer \(self.getToken()!)") ?? ""]
                        
                        let params = [
                            "text":"\(upLoadText!)",
                            "hashtags":upLoadHash,
                            "imgs": resendImage
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
                                let result1: Post? = try? decoder.decode(Post.self, from: data)
                                print(data)

                                if result1?.status == 200 {
                                    self.dismiss(animated: true)
                                }else if result?.status == 204 {
                                    self.dismiss(animated: true)
                                }

                            case .failure(let error):
                                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                                self.dismiss(animated: true)
                            }
                        }
                        
                    }
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                    self.dismiss(animated: true)
                }
                
                
            }
    }

    func setupLayout(){
        [imageView, textView, hashtagTextField].forEach{ view.addSubview($0) }
        
        let imageViewInset: CGFloat = 16.0
        
        imageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(imageViewInset)
            $0.leading.equalToSuperview().inset(imageViewInset)
            $0.width.equalTo(100.0)
            $0.height.equalTo(imageView.snp.width)
        }
        
        textView.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.top)
            $0.leading.equalTo(imageView.snp.trailing).offset(imageViewInset)
            $0.trailing.equalToSuperview().inset(imageViewInset)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
        
        hashtagTextField.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(imageViewInset)
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(textView.snp.trailing)
        }
    }
    
    func getToken() -> String? {
        guard let token = try? self.keychain.getString("token") else { return nil }
        return token
    }
}
