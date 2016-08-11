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
    func categoryListViewController(viewController: UIViewController?, selectedCategory: Category)
}

class CategoryListViewController: UITableViewController {

    var delegate: CategoryListViewControllerDelegate!
    
    private let viewModel = CategoryListViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTableView()
    }
    
    private func bindTableView() {
        viewModel.categories.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell")) { index, category, cell in
                cell.textLabel?.text = category.name
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_modelSelected(Category)
            .subscribeNext { [weak self] category in
                self?.delegate.categoryListViewController(self, selectedCategory: category)
            }
            .addDisposableTo(disposeBag)
    }
}
