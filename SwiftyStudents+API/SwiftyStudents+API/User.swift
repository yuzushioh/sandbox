//
//  User.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/6/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Himotoki

struct User: JSONObject {
    let id: Int64
    let name: String
    
    init(e: Extractor) throws {
        id = try e.value("id")
        name = try e.value("name")
    }
}
