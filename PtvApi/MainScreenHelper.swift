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
    private func getHealthCheckCriteria(apiDataJson: JSON) -> NSMutableArray
    {
        let healthCheckCriteria: NSMutableArray = NSMutableArray()
        
        for (apiCheck, _) in apiDataJson
        {
            healthCheckCriteria.addObject(apiCheck as String)
        }
        
        return healthCheckCriteria
    }
    
    func setMainTitleText(mainTitle: UILabel) -> Void
    {
        mainTitle.text = "Connecting to PTV API..."
        mainTitle.font = UIFont.systemFontOfSize(16)
        mainTitle.textColor = UIColor.blackColor()
    }
    
    func arrangeOverallHealthCheckResultHeading() -> UILabel
    {

        let healthCheckTitle = UILabel(frame: CGRectMake(50, 75, 200, 100))
        healthCheckTitle.text = "Healthcheck results: "
        
        return healthCheckTitle
    }
    
    func arrangeOverallHealthCheckResult(apiDataJson: JSON) -> UILabel
    {
        let healthCheckOverallResultLabel = UILabel(frame: CGRectMake(220, 75,100, 100))
        healthCheckOverallResultLabel.font = UIFont.boldSystemFontOfSize(16)
        
        for heading in getHealthCheckCriteria(apiDataJson)
        {
            if apiDataJson[(heading as? String)!]
            {
                healthCheckOverallResultLabel.text = "PASS"
                healthCheckOverallResultLabel.textColor = UIColor.greenColor()
            }
            else
            {
                healthCheckOverallResultLabel.text = "FAIL"
                healthCheckOverallResultLabel.textColor = UIColor.redColor()
                break
            }
        }
        
        return healthCheckOverallResultLabel
    }
    
    func insertHealthCheckResults(apiDataJson: JSON, mainView: UIView) -> Void
    {
        var yPosition: CGFloat = 100
        
        for heading in getHealthCheckCriteria(apiDataJson)
        {
            let criteriaLabel = UILabel(frame: CGRectMake(75, yPosition, 200, 100))
            criteriaLabel.text = heading as? String
            criteriaLabel.font = UIFont.systemFontOfSize(14)
            mainView.addSubview(criteriaLabel)
            
            let statusLabel = UILabel(frame: CGRectMake(220, yPosition, 100, 100))
            statusLabel.text = apiDataJson[(heading as? String)!].stringValue
            statusLabel.font = UIFont.boldSystemFontOfSize(14)
            mainView.addSubview(statusLabel)
            
            if !apiDataJson[(heading as? String)!]
            {
                criteriaLabel.textColor = UIColor.redColor()
                statusLabel.textColor = UIColor.redColor()
            }
            
            yPosition += 20
        }
    }
}