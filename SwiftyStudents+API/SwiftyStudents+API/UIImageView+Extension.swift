//
//  UIImageView+Extension.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(from URL: URL) {
        self.kf.setImage(
            with: URL,
            placeholder: nil,
            options: [.transition(.fade(0.3))],
            progressBlock: nil,
            completionHandler: nil
        )
    }
}
