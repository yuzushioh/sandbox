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
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionPlaceholder: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    
    fileprivate let viewModel = PostViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewState()
        bindUI()
    }
    
    fileprivate func bindViewState() {
        viewModel.textViewPlaceholderHidden
            .bindTo(descriptionPlaceholder.rx.hidden)
            .addDisposableTo(disposeBag)
        
        viewModel.postButtonEnabled
            .map { $0 ? UIColor(red: 0/255, green: 189/255, blue: 156/255, alpha: 1) : UIColor.lightGray }
            .bindNext { [weak self] color in
                self?.postButton.backgroundColor = color
            }
            .addDisposableTo(disposeBag)
        
        viewModel.postButtonEnabled
            .bindTo(postButton.rx.enabled)
            .addDisposableTo(disposeBag)
        
        viewModel.loading
            .bindNext { loading in
                // ここでこのloadingをindicatorViewなどのrx_animatingなどにbindする。
            }
            .addDisposableTo(disposeBag)
        
        viewModel.requestCompleted
            .bindNext { post in
                // 投稿が成功した時の処理を行う
            }
            .addDisposableTo(disposeBag)
        
        viewModel.error
            .bindNext { error in
                // 投稿の通信でerrorが出てしまった場合の処理を行う
            }
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func bindUI() {
        titleTextField.rx.text
            .bindTo(viewModel.title)
            .addDisposableTo(disposeBag)
        
        descriptionTextView.rx.text
            .bindTo(viewModel.description)
            .addDisposableTo(disposeBag)
        
        priceTextField.rx.text
            .map { price in
                if let price = Int(price.extractDigitCharacter ) {
                    return price
                } else {
                    return 0
                }
            }
            .bindTo(viewModel.price)
            .addDisposableTo(disposeBag)
        
        viewModel.title
            .bindTo(titleTextField.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.description
            .bindTo(descriptionTextView.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.price
            .map { price in
                return price == 0 ? "" : "¥\(price)"
            }
            .bindTo(priceTextField.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.image
            .bindNext { [weak self] image in
                self?.selectedImageView.image = image
            }
            .addDisposableTo(disposeBag)
        
        viewModel.category
            .map { $0.name }
            .bindTo(categoryLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        postButton.rx.tap
            .bindTo(viewModel.postTrigger)
            .addDisposableTo(disposeBag)
        
        selectImageButton.rx.tap
            .bindNext { [weak self] _ in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                self?.present(imagePicker, animated: true, completion: nil)
            }
            .addDisposableTo(disposeBag)
    }
}

extension PostViewController: CategoryListViewControllerDelegate {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 3 && (indexPath as NSIndexPath).row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CategoryListViewController") as! CategoryListViewController
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func categoryListViewController(_ viewController: UIViewController?, selectedCategory: Category) {
        
        viewModel.category.onNext(selectedCategory)
        navigationController?.popViewController(animated: true)
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard info[UIImagePickerControllerOriginalImage] != nil else {
            return
        }
        
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        viewModel.image.onNext(photo)
        
        picker.dismiss(animated: true, completion: nil)
    }
}

