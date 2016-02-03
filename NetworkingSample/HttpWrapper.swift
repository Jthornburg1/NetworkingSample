//
//  File.swift
//  NetworkingSample
//
//  Created by Jon Thornburg on 2/2/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

protocol HttpWrapper {
    static func sendRequest(request: NSURLRequest, completion:(NSData!, NSError!) -> Void) -> ()
}

public class HttpWrapperImpl: HttpWrapper{
    public class func sendRequest(request: NSURLRequest, completion: (NSData!, NSError!) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {(data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("sendRequest error")
                    completion(data, error)
            })
                return
    }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                        completion(data, nil)
                    } else {
                        let responseError : NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: nil)
                        completion(data, responseError)
                    }
                }
            })
        }
        task.resume()
    }
}
