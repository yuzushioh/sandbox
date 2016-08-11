//
//  CategoryListViewModel.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/10/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import RxSwift

class CategoryListViewModel {
    
    let categories: Variable<[Category]>!
    
    init() {
        categories = Variable(Category.categories)
    }
}
