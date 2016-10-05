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
    func categoryListViewController(_ viewController: UIViewController?, selectedCategory: Category)
}

class CategoryListViewController: UITableViewController {

    var delegate: CategoryListViewControllerDelegate!
    
    fileprivate let viewModel = CategoryListViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTableView()
    }
    
    fileprivate func bindTableView() {
        viewModel.categories.asObservable()
            .bindTo(tableView.rx.items(cellIdentifier: "Cell")) { index, category, cell in
                cell.textLabel?.text = category.name
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx.modelSelected(Category.self)
            .bindNext { [weak self] category in
                self?.delegate.categoryListViewController(self, selectedCategory: category)
            }
            .addDisposableTo(disposeBag)
    }
}
