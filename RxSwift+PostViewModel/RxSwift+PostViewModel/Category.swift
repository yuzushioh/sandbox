//
//  Category.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/11/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Foundation

struct Category {
    let id: Int
    let name: String
}

extension Category {
    static var categories: [Category] {
        return [
            Category(id: 1, name: "ファッション"),
            Category(id: 2, name: "ゲーム"),
            Category(id: 3, name: "自転車・自動車")
        ]
    }
}

