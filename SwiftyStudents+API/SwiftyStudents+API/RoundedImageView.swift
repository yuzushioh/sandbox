//
//  RoundedImageView.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        self.layer.cornerRadius = self.bounds.width/2
        self.clipsToBounds = true
    }
}
