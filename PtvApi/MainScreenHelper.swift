//
//  MainScreenHelper.swift
//  PtvApi
//
//  Created by Vignesh Sankaran on 6/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class MainScreenHelper
{
    func setMainTitleText(inout mainTitle: UILabel) -> Void
    {
        mainTitle.text = "Connecting to PTV API..."
        mainTitle.font = UIFont.systemFontOfSize(16)
        mainTitle.textColor = UIColor.blackColor()
    }
    
    func arrangeHealthCheckCriteriaHeadings(apiJsonData: JSON) -> UILabel
    {
        let healthCheckCriteria: NSMutableArray = NSMutableArray()
        
        for (apiCheck, _) in apiJsonData
        {
            healthCheckCriteria.addObject(apiCheck as String)
        }
        
        let healthCheckTitle = UILabel(frame: CGRectMake(50, 75, 200, 100))
        healthCheckTitle.text = "Healthcheck results: "
        
        return healthCheckTitle
    }
    
    func arrangeHealthCheckCriteriaResults(inout mainView: UIView) -> Void
    {
        
    }
}