//
//  File.swift
//  NetworkingSample
//
//  Created by Jon Thornburg on 2/3/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

import UIKit

public struct HttpRequest {
    
    static func createRequest(urlString: String) -> NSURLRequest {
        let url: NSURL = NSURL(string: urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
}
