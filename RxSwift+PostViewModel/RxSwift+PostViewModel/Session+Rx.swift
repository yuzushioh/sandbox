//
//  Session+Rx.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/7/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import RxSwift
import APIKit

extension Session {
    func rx_responseFrom<T: Request>(_ request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            self.send(request) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {}
        }
    }
}
