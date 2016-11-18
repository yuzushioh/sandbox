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
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
    }
}

extension EditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.characters.isEmpty
    }
}
