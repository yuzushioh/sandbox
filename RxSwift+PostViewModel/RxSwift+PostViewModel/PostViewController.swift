//
//  ViewController.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/7/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import RxSwift

class PostViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    
    private let viewModel = PostViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewState()
        bindUI()
        bindUIInput()
    }
    
    private func bindViewState() {
        
    }
    
    private func bindUI() {
        
    }
    
    private func bindUIInput() {
        
    }
}

