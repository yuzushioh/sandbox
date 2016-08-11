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
    
    let error = PublishSubject<ErrorType>()
    
    let title = PublishSubject<String>()
    let description = PublishSubject<String>()
    let category = PublishSubject<Category>()
    let price = PublishSubject<Int>()
    let image = PublishSubject<UIImage>()
    
    var loading: Observable<Bool> {
        return isLoading.asObservable()
    }
    
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
                    category: category.id,
                    price: price,
                    mediaId: ""
                )
            }
    }
    
    init() {
        bindPostRequest()
    }
    
    private let disposeBag = DisposeBag()
    private let isLoading: Variable<Bool> = Variable(false)
    
    let postTrigger = PublishSubject<Void>()
    let requestCompleted = PublishSubject<Post>()
    
    private func bindPostRequest() {
        let mediaId = postTrigger
            .withLatestFrom(image)
            .flatMap { image in
                // ここで画像をAPIに送り、idを受け取る
                return Observable.just("media id comes here")
            }
        
        let request = mediaId
            .withLatestFrom(postRequest) { $0 }
            .map { id, request -> PostService.PostRequest in
                var request = request
                request.mediaId = id
                
                return request
            }
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
            .bindTo(isLoading)
            .addDisposableTo(disposeBag)
        
        response
            .bindTo(requestCompleted)
            .addDisposableTo(disposeBag)
    }
}
