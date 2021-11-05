//
//  UploadViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/13.
//

import SnapKit
import UIKit
import Alamofire
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
        textfield.placeholder = "# 를 입력하세요! (해쉬테그는 ','로 구분됩니다.)"
        textfield.font = .systemFont(ofSize: 13.0, weight: .medium)
        textfield.borderStyle = .none
        
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setUpNavigationItem()
        setupLayout()
        
        imageView.image = uploadImage
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
        
        var temp = ""
        let upLoadImageURL = temp
        let upLoadText = textView.text
        let upLoadHash = hashtagTextField.text
        
        
        // 처음 이미지만 보내주는 코드
        let uploadImageUrl1: URL = URL(string: "\(super.MainURL)/writings/upload/imgs")!
        let uploadImageUrl = "\(super.MainURL)/writings/upload/imgs"
        let urlConvertible: Alamofire.URLConvertible = uploadImageUrl
        
        var imageRequest = URLRequest(url: uploadImageUrl1)
        imageRequest.httpMethod = "POST"
        imageRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        imageRequest.setValue(getToken() ?? "", forHTTPHeaderField: "token")
        imageRequest.timeoutInterval = 10
        
//        sendImage(data!, url: urlConvertible)
        print("토큰 값 \n", getToken() ?? "")
        upload(image: data, to: uploadImageUrl)
        
        sleep(1)
        
        
        // 이미지와 글, 해쉬태그 보내주는 코드
        let upLoadUrl = "\(super.MainURL)/writings/upload"
        var request = URLRequest(url: URL(string: upLoadUrl)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = [
            "text":"\(upLoadText!)",
            "hashtags":"\(upLoadHash!)",
            "imgs":"\(upLoadImageURL)"
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
                let result: Post? = try? decoder.decode(Post.self, from: data)
                print(data)
                
                if result?.status == 200{
                    
                    
                    
                    self.dismiss(animated: true)
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
    
    func upload(image: Data, to url: String) {
        let headers1: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Authorization": ("Bearer \(getToken()!)") ?? ""
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image, withName: "image", fileName: "image.png", mimeType: "image/jpeg")
        }, to: url, headers: headers1)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("POST 성공")
                    let decoder = JSONDecoder()
                    let result: Post? = try? decoder.decode(Post.self, from: data)
                    print(data)
                    print(" 헤더  \(headers1)")
                    
                    print(result?.status)
                    print(result?.message)
                    print(result?.error)
                    
                    if result?.status == 200{
                        self.dismiss(animated: true)
                    }else{
                        self.dismiss(animated: true)
                    }
                    
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                    self.dismiss(animated: true)
                }
            }
    }
}

//    func sendImage(_ image: Data, url: URLConvertible) {
//        let header : HTTPHeaders = ["Content-type" : "multipart/form-data"]
//        AF.upload(multipartFormData: {
//            $0.append(image, withName: "thumbnail", fileName: "imgs.jpeg", mimeType: "image/jpeg")
//        }, to: url, usingThreshold: UInt64.init(), method: .post ,headers: header)
//            .responseData() { response in
//                switch response.result {
//                case .success(let data):
//                    print("POST 성공")
//                    let decoder = JSONDecoder()
//                    let result: Post? = try? decoder.decode(Post.self, from: data)
//                    print(data)
//                    dump(result?.status)
//
//                    if result?.status == 200{
//                        self.dismiss(animated: true)
//                    }else{
//                        self.dismiss(animated: true)
//                    }
//
//                case .failure(let error):
//                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
//                    self.dismiss(animated: true)
//                }
//            }
//
//    }
