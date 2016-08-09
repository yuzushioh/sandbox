//
//  PostViewModel.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/7/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import APIKit

class PostViewModel {
    
    let loading = BehaviorSubject(value: false)
    let error = PublishSubject<ErrorType>()
    
    let title = PublishSubject<String>()
    let description = PublishSubject<String>()
    let category = PublishSubject<Int>()
    let price = PublishSubject<Int>()
    let image = PublishSubject<UIImage>()
    
    var textViewPlaceholderHidden: Observable<Bool> {
        return description.map { !$0.isEmpty }
    }
    
    var postButtonEnabled: Observable<Bool> {
        return Observable
            .combineLatest(title, description, category, price, image) { title, description, category, price, image -> Bool in
                return !title.isEmpty && !description.isEmpty && price != 0
            }
            .startWith(false)
    }
    
    private var postRequest: Observable<PostService.PostRequest> {
        return Observable
            .combineLatest(title, description, category, price) { title, description, category, price in
                return PostService.PostRequest(
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
    let completedTrigger = PublishSubject<Post>()
    
    private func bindPostRequest() {
        let request = postTrigger
            .withLatestFrom(postRequest)
            .shareReplay(1)
        
        let response = request
            .flatMap { request in
                return Session.sharedSession.rx_responseFrom(request)
                    .doOnError { [weak self] error in
                        self?.error.onNext(error)
                    }
                    .catchError { _ in Observable.empty() }
            }
            .shareReplay(1)
        
        Observable
            .of(
                request.map { _ in true },
                response.map { _ in false }
            )
            .merge()
            .bindTo(loading)
            .addDisposableTo(disposeBag)
        
        response
            .bindTo(completedTrigger)
            .addDisposableTo(disposeBag)
    }
}
