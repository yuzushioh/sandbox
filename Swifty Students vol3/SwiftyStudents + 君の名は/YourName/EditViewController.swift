//
//  EditViewController.swift
//  YourName
//
//  Created by yuzushioh on 11/13/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    var calender: Calender!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.delegate = self
        
        if let existedTitle = UserDefaultsManager.get(titleOf: calender.day) {
            titleTextField.text = existedTitle
        }
        
        if let existedDairy = UserDefaultsManager.get(diaryOf: calender.day) {
            placeholderLabel.isHidden = true
            descriptionTextView.text = existedDairy
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if let title = titleTextField.text, title != "" {
            UserDefaultsManager.add(title: title, forDay: calender.day)
        }
        
        if let diary = descriptionTextView.text, diary != "" {
            UserDefaultsManager.add(diary: diary, forDay: calender.day)
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension EditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.characters.isEmpty
    }
}
