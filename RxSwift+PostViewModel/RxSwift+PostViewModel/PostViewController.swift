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
    
    private let viewModel = PostViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewState()
        bindUI()
    }
    
    private func bindViewState() {
        viewModel.textViewPlaceholderHidden
            .bindTo(descriptionPlaceholder.rx_hidden)
            .addDisposableTo(disposeBag)
        
        viewModel.postButtonEnabled
            .map { $0 ? UIColor(red: 0/255, green: 189/255, blue: 156/255, alpha: 1) : UIColor.lightGrayColor() }
            .subscribeNext { [weak self] color in
                self?.postButton.backgroundColor = color
            }
            .addDisposableTo(disposeBag)
        
        viewModel.postButtonEnabled
            .bindTo(postButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        viewModel.loading
            .subscribeNext { loading in
                print(loading)
                // ここでこのloadingをindicatorViewなどのrx_animatingなどにbindする。
            }
            .addDisposableTo(disposeBag)
        
        viewModel.requestCompleted
            .subscribeNext { post in
                print(post)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func bindUI() {
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
        
        viewModel.price
            .map { price in
                return price == 0 ? "" : "¥\(price)"
            }
            .bindTo(priceTextField.rx_text)
            .addDisposableTo(disposeBag)
        
        postButton.rx_tap
            .bindTo(viewModel.postTrigger)
            .addDisposableTo(disposeBag)
        
        selectImageButton.rx_tap
            .subscribeNext { [weak self] _ in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                self?.presentViewController(imagePicker, animated: true, completion: nil)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.image
            .subscribeNext { [weak self] image in
                self?.selectedImageView.image = image
            }
            .addDisposableTo(disposeBag)
        
        viewModel.category
            .map { $0.name }
            .bindTo(categoryLabel.rx_text)
            .addDisposableTo(disposeBag)
    }
}

extension PostViewController: CategoryListViewControllerDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 3 && indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("CategoryListViewController") as! CategoryListViewController
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func categoryListViewController(viewController: UIViewController?, selectedCategory: Category) {
        
        viewModel.category.onNext(selectedCategory)
        navigationController?.popViewControllerAnimated(true)
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard info[UIImagePickerControllerOriginalImage] != nil else {
            return
        }
        
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        viewModel.image.onNext(photo)
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

