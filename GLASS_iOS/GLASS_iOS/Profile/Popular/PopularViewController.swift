//
//  PopularViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/18.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher
import KeychainAccess

class PopularViewController: MainURL{
    
    fileprivate let keychain = Keychain(service: "B1ND-6th.GLASS-iOS")
    fileprivate var Writings2: [Writings2] = []
    
    private lazy var popularTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        
        tableView.register(PopularTableViewCell.self, forCellReuseIdentifier: "PopularTableViewCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarItem()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let upLoadUrl = "\(super.MainURL)/posts/popular"
        var request = URLRequest(url: URL(string: upLoadUrl)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = ["Authorization":("Bearer \(getToken()!)") ?? ""]
        
        AF.request(request).responseData { [weak self] (response) in
            switch response.result{
            case .success(let data):
                
                print("GET 성공")
                let decoder = JSONDecoder()
                let result = try? decoder.decode(Popular.self, from: data)
                
                self?.Writings2 = result?.writings ?? []
                
                self?.popularTableView.reloadData()
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
        
    }
    
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Writings2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as? PopularTableViewCell
        
        // PostImageurl 넣어주기
        let PostImageurl = URL(string: "\(super.MainURL)/uploads\(self.Writings2[indexPath.row].imgs[0])")
        cell!.postImageView.kf.setImage(with: PostImageurl, placeholder: UIImage(named: "GLASS_Small"))
        
        // studentInformationLabel 넣어주기
        cell!.studentInformationLabel.text = "\(self.Writings2[indexPath.row].owner.grade)\(self.Writings2[indexPath.row].owner.classNumber)\(self.Writings2[indexPath.row].owner.stuNumber)  \(self.Writings2[indexPath.row].owner.name)"
        
        // currentLikedCountLabel 넣어주기
        cell!.likeButtonCount.text = "\(self.Writings2[indexPath.row].likeCount)"
        
        // titleLabel 넣어주기
        cell!.titleLabel.text = "\(self.Writings2[indexPath.row].text!)"
        
        // tagLabel 넣어주기
        cell!.tagLabel.text = "# \(String(describing: self.Writings2[indexPath.row].hashtags[0]!))"
        
        cell?.selectionStyle = .none
        cell?.setup()
        
        return cell ?? UITableViewCell()
    }
}



private extension PopularViewController{
    
    func getToken() -> String? {
        guard let token = try? self.keychain.getString("token") else { return nil }
        return token
    }
    
    func setNavigationBarItem() {
        navigationItem.title = "인기글"
    }
    
    func setupTableView(){
        view.addSubview(popularTableView)
        popularTableView.snp.makeConstraints{ $0.edges.equalToSuperview()}
    }
    
}
