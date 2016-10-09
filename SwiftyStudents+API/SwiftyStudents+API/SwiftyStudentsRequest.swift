//
//  SwiftyStudentsRequest.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

protocol SwiftyStudentsResponse {
    associatedtype Element
    var elements: [Element] { get }
}

protocol SwiftyStudentsRequest: Request {
    associatedtype Response: SwiftyStudentsResponse
}

extension SwiftyStudentsRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        guard let response = object as? Self.Response else {
            throw ResponseError.unexpectedObject(object)
        }
        
        return response
    }
}

extension SwiftyStudentsRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        return try decodeValue(object)
    }
}
