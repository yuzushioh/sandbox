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
    @IBOutlet weak var descriptionPlaceholder: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    
    private let viewModel = PostViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewState()
        bindUIInput()
    }
    
    private func bindViewState() {
        viewModel.textViewPlaceholderHidden
            .bindTo(descriptionPlaceholder.rx_hidden)
            .addDisposableTo(disposeBag)
        
        viewModel.loading
            .subscribeNext { loading in
                print(loading)
                
                // ここでこのloadingをindicatorViewなどのrx_animatingなどにbindする。
            }
            .addDisposableTo(disposeBag)
    }
    
    private func bindUIInput() {
        titleTextField.rx_text
            .bindTo(viewModel.title)
            .addDisposableTo(disposeBag)
        
        descriptionTextView.rx_text
            .bindTo(viewModel.description)
            .addDisposableTo(disposeBag)
        
        priceTextField.rx_text
            .map { price in
                if let price = Int(price.extractDigitCharacter ) {
                    return price
                } else {
                    return 0
                }
            }
            .bindTo(viewModel.price)
            .addDisposableTo(disposeBag)
    }
}

