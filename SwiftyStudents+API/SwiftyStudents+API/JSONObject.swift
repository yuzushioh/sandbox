//
//  JSONObject.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/6/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Himotoki
import Foundation

protocol JSONObject: Decodable {
    init(e: Extractor) throws
}

extension JSONObject {
    static func decode(_ e: Extractor) throws -> Self {
        return try Self(e: e)
    }
}

