//
//  Calender.swift
//  YourName
//
//  Created by yuzushioh on 11/8/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Foundation

struct Calender {
    let month: Int = 12
    let day: Int
    
    init(day: Int) {
        self.day = day
    }
}

extension Calender {
    static var december: [Calender] {
        return (1...31).map { Calender(day: $0) }
    }
}
