//
//  PtvApi.swift
//  PtvApi
//
//  Created by Vignesh Sankaran on 6/01/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let apiKeyPath : String = NSBundle.mainBundle().pathForResource("ApiKeys", ofType: "plist")!
let keys : NSDictionary = NSDictionary(contentsOfFile: apiKeyPath)!

let baseUrl : String = "http://timetableapi.ptv.vic.gov.au"
let devId : String = keys["DevId"] as! String

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


private func createHmacSignature(callUrl: String) -> String
{
    let unencodedKey : String = keys["SecurityKey"] as! String
    
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

func newHealthCheck(callback: (apiData: NSData?) -> Void) -> Void
{
    let healthCheckUrl : String = "/v2/healthcheck?timestamp=" + NSDate().formattedISO8601 + "&devid=" + devId
    let hmacSignature : String = createHmacSignature(healthCheckUrl)
    let requestUrl : String = baseUrl + healthCheckUrl + "&signature=" + hmacSignature
    
    NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: requestUrl)!) {
        data, response, error in
            callback(apiData: data)
    }.resume()
    
    
    
}

func healthCheck(callback: (apiResponse: Response<AnyObject, NSError>) -> Void) -> Void
{
    
    let healthCheckUrl : String = "/v2/healthcheck?timestamp=" + NSDate().formattedISO8601 + "&devid=" + devId
    let hmacSignature : String = createHmacSignature(healthCheckUrl)
    let requestUrl : String = baseUrl + healthCheckUrl + "&signature=" + hmacSignature
    
    Alamofire.request(.GET, requestUrl).responseJSON
    {
        response in
            callback(apiResponse: response)
    }
}