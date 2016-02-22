//
//  PtvApi.swift
//  PtvApi
//
//  Created by Vignesh Sankaran on 6/01/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

import Foundation
import UIKit

// The below ISO8601 date stamp extension is attributed to Leo Dabus. Retrieved from http://stackoverflow.com/a/28016692/5891072
extension NSDate {
    struct Date {
        static let formatterISO8601: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
            return formatter
        }()
    }
    var formattedISO8601: String { return Date.formatterISO8601.stringFromDate(self) }
}

class PtvApi: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate
{
    
    struct constants
    {
        static let apiKeyPath : String = NSBundle.mainBundle().pathForResource("ApiKeys", ofType: "plist")!
        static let keys : NSDictionary = NSDictionary(contentsOfFile: apiKeyPath)!
        
        static let baseUrl : String = "http://timetableapi.ptv.vic.gov.au"
        static let devId : String = keys["DevId"] as! String
    }
    

    private func createHmacSignature(callUrl: String) -> String
    {
        // The code to create the HMAC signature is attributed to Airspeed Velocity. Retrieved from http://stackoverflow.com/a/29799802/5891072
        let unencodedKey : String = constants.keys["SecurityKey"] as! String
        
        let encodedKey = unencodedKey.cStringUsingEncoding(NSUTF8StringEncoding)
        let encodedData = callUrl.cStringUsingEncoding(NSUTF8StringEncoding)
        
        let algorithm : CCHmacAlgorithm = CCHmacAlgorithm(kCCHmacAlgSHA1)
        var result : [CUnsignedChar] = Array(count: Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        
        CCHmac(algorithm, encodedKey!, encodedKey!.count-1, encodedData!, encodedData!.count-1, &result)
        
        let hash = NSMutableString()
        
        for val in result
        {
            hash.appendFormat("%02hhx", val)
        }
        
        return hash as String
    }
    
    func healthCheck(callback: (apiResponse: NSURLResponse?, apiData: NSData?) -> Void) -> Void
    {
        let healthCheckUrl : String = "/v2/healthcheck?timestamp=" + NSDate().formattedISO8601 + "&devid=" + constants.devId
        let hmacSignature : String = createHmacSignature(healthCheckUrl)
        let requestUrl : String = constants.baseUrl + healthCheckUrl + "&signature=" + hmacSignature
        
        let configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let apiRequestSession: NSURLSession = NSURLSession(configuration: configuration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: requestUrl)!)
        
        
        let task = apiRequestSession.dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if error != nil
                {
                    debugPrint(error)
                }

                callback(apiResponse: response, apiData: data)
        }
        task.resume()
    }
}