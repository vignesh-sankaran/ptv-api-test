//
//  ViewController.swift
//  PtvApi
//
//  Created by Vignesh Sankaran on 5/01/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainView = UIView(frame: CGRectMake(0,0, 1000, 750))
        self.view.addSubview(mainView)
        
        var mainTitle = UILabel(frame: CGRectMake(50, 50, 200, 100))
        MainScreenHelper().setMainTitleText(&mainTitle)
        mainView.addSubview(mainTitle)
        
        PtvApi().healthCheck({ (apiResponse, apiData) -> Void in

            mainTitle.text = "API Connection: "
            
            let apiDataJson = JSON(data: apiData!)
            
            mainView.addSubview(MainScreenHelper().arrangeHealthCheckCriteriaHeadings(apiDataJson))
            
            let healthCheckCriteria: NSMutableArray = NSMutableArray()
            
            for (apiCheck, _) in apiDataJson
            {
                healthCheckCriteria.addObject(apiCheck as String)
            }

            
            let healthCheckOverallResultLabel = UILabel(frame: CGRectMake(220, 75,100, 100))
            healthCheckOverallResultLabel.font = UIFont.boldSystemFontOfSize(16)
            
            for heading in healthCheckCriteria
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
            
            mainView.addSubview(healthCheckOverallResultLabel)
            
            var yPosition: CGFloat = 100
            
            for heading in healthCheckCriteria
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
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

