//
//  PostViewModel.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/7/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import RxSwift
import APIKit

class PostViewModel {
    
    let loading = BehaviorSubject(value: false)
    let error = PublishSubject<ErrorType>()
    
    let title = PublishSubject<String>()
    let description = PublishSubject<String>()
    let category = PublishSubject<String>()
    let price = PublishSubject<Int>()
    let photo = PublishSubject<UIImage>()
    
    private var postRequest: Observable<PostService.Post> {
        return Observable
            .combineLatest(title, description, category, price) { title, description, category, price in
                return PostService.Post(
                    title: title,
                    description: description,
                    category: category,
                    price: price,
                    mediaId: ""
                )
            }
    }
    
    init() {
        bindPostRequest()
    }
    
    private let disposeBag = DisposeBag()
    
    let postTrigger = PublishSubject<Void>()
    
    private func bindPostRequest() {
        let request = postTrigger
            .withLatestFrom(postRequest)
            .shareReplay(1)
    }
}
