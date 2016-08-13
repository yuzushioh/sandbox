//
//  ToastView.swift
//  iOSDCRejetcedConference
//
//  Created by 福田涼介 on 8/14/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit

class ToastView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.alpha = 0.8
        
        self.layer.cornerRadius = 13
        self.clipsToBounds = true
    }
}
