//
//  SearchViewController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/15.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private lazy var searchTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "검색할 검색어를 입력하세요."
        
        
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
