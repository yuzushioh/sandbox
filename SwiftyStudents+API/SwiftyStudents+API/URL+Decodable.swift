//
//  NSURL+Decodable.swift
//  SwiftyStudents+API
//
//  Created by yuzushioh on 10/9/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import UIKit
import Himotoki

public enum NSURLDecodeError: Error {
    case UnexpectedRawValue(AnyObject)
    case IllegalFormatString(String)
}

extension URL: Decodable {
    public static func decode(_ e: Extractor) throws -> URL {
        guard let string = e.rawValue as? String else {
            throw NSURLDecodeError.UnexpectedRawValue(e.rawValue as AnyObject)
        }
        
        guard let URL = self.init(string: string) else {
            throw NSURLDecodeError.IllegalFormatString(string)
        }
        
        return URL
    }
}
