//
//  ListViewCell.swift
//  YourName
//
//  Created by yuzushioh on 11/8/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var calender: Calender? {
        didSet {
            guard let calender = calender else {
                return
            }
            
            dateLabel.text = "\(calender.day)"
            
            if let existedDiary = UserDefaultsManager.get(diaryOf: calender.day) {
                descriptionLabel.text = existedDiary
            } else {
                descriptionLabel.text = "タップして書く!"
            }
            
            if let existedTitle = UserDefaultsManager.get(titleOf: calender.day) {
                titleLabel.text = existedTitle
            } else {
                titleLabel.text = "日記を書こう"
            }
        }
    }
}
