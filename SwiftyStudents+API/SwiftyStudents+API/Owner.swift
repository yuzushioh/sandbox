//
//  Owner.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Foundation
import Himotoki

struct Owner: JSONObject {
    let id: Int64
    let name: String
    let avatarURL: URL
    let profileURL: URL
    
    init(e: Extractor) throws {
        id = try e.value("id")
        name = try e.value("login")
        avatarURL = try e.value("avatar_url")
        profileURL = try e.value("url")
    }
}
