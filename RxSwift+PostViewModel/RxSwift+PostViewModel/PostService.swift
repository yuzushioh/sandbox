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
    struct Post: RequestType {
        typealias Response = Post
        
        var baseURL: NSURL {
            return NSURL(string: "")!
        }
        
        var path: String {
            return "post"
        }
        
        var method: HTTPMethod {
            return .GET
        }
        
        func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Post.Response {
            guard let response = object as? Post.Response else {
                throw ResponseError.UnexpectedObject(object)
            }
            
            return response
        }
    }
}
