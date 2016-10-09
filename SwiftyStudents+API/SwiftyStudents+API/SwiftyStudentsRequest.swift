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

protocol SwiftyStudentsRequest: Request {
    
}

extension SwiftyStudentsRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

extension SwiftyStudentsRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        return try decodeValue(object)
    }
}
