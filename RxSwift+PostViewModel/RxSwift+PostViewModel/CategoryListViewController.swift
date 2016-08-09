//
//  CategoryListViewController.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/10/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CategoryListViewControllerDelegate {
    func categoryListViewController(viewController: UIViewController?, selectedCategoryId: Int)
}

class CategoryListViewController: UITableViewController {

    var delegate: CategoryListViewControllerDelegate!
    
    private let viewModel = CategoryListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTableView()
    }
    
    private func bindTableView() {
        
    }
}
