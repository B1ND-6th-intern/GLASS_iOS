//
//  PopularViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/18.
//

import UIKit
import SnapKit

class PopularViewController: MainURL{
    
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
    
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as? PopularTableViewCell
        cell?.selectionStyle = .none
        cell?.setup()
        
        return cell ?? UITableViewCell()
    }
}



private extension PopularViewController{
    
    func setNavigationBarItem() {
        navigationItem.title = "인기글"
    }
    
    func setupTableView(){
        view.addSubview(popularTableView)
        popularTableView.snp.makeConstraints{ $0.edges.equalToSuperview()}
    }
    
}
