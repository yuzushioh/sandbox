//
//  APIManager.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Foundation
import APIKit
import Result

final class APIManager<Request: SwiftyStudentsRequest> {
    private(set) var elements: [Request.Response.Element] = []
    private(set) var error: SessionTaskError?
    
    func sendRequest(request: Request, completion: ((Void) -> Void)? = nil) {
        Session.shared.send(request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.elements = []
                self?.elements = response.elements
            case .failure(let error):
                self?.error = error
            }
            completion?()
        }
    }
}
