//
//  GithubRequest.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

final class GithubService {
    struct SearchRepositories: SwiftyStudentsRequest {
        typealias Response = SearchRepositoriesResult
        
        let query: String
        
        var path: String {
            return "/search/repositories"
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var parameters: Any? {
            return ["q": query]
        }
    }
}

struct SearchRepositoriesResult: JSONObject {
    
    init(e: Extractor) throws {
        
    }
}
