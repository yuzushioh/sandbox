//
//  Reposirory.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Foundation
import Himotoki

struct Reposirory: JSONObject {
    let id: Int64
    let name: String
    let owner: Owner
    let description: String
    
    init(e: Extractor) throws {
        id = try e.value("id")
        name = try e.value("name")
        owner = try e.value("owner")
        description = try e.value("description")
    }
}
