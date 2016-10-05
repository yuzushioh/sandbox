//
//  PostService.swift
//  RxSwift+PostViewModel
//
//  Created by 福田涼介 on 8/7/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import APIKit

class PostService {
    struct PostRequest: Request {
        typealias Response = Post
        
        let title: String
        let description: String
        let category: Int
        let price: Int
        var mediaId: String
        
        var baseURL: URL {
            return URL(string: "")!
        }
        
        var path: String {
            return "post"
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Post {
            guard let response = object as? PostRequest.Response else {
                throw ResponseError.unexpectedObject(object)
            }
            
            return response
        }
    }
}
