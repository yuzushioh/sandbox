//
//  PostViewModel.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/7/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import RxSwift

class PostViewModel {
    
    let loading = BehaviorSubject(value: false)
    let error = PublishSubject<ErrorType>()
    
    let title = PublishSubject<String>()
    let description = PublishSubject<String>()
    let category = PublishSubject<String>()
    let price = PublishSubject<Int>()
    let photo = PublishSubject<UIImage>()
    
    private var request: Observable<Void> {
        return Observable
            .combineLatest(title, photo, description, category, price) { title, photo, description, category, price in
                return ()
            }
    }
    
    init() {
        bindPostRequest()
    }
    
    private let disposeBag = DisposeBag()
    
    let postTrigger = PublishSubject<Void>()
    
    private func bindPostRequest() {
        
    }
}
