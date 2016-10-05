//
//  String+Ex.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Foundation

extension String {
    var extractDigitCharacter: String {
        let digitArray = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let price = digitArray.joined(separator: "")
        return price
    }
}
