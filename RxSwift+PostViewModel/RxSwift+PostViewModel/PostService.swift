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
    struct PostRequest: RequestType {
        typealias Response = Post
        
        let title: String
        let description: String
        let category: String
        let price: Int
        var mediaId: String
        
        var baseURL: NSURL {
            return NSURL(string: "")!
        }
        
        var path: String {
            return "post"
        }
        
        var method: HTTPMethod {
            return .GET
        }
        
        func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> PostRequest.Response {
            guard let response = object as? PostRequest.Response else {
                throw ResponseError.UnexpectedObject(object)
            }
            
            return response
        }
    }
}
