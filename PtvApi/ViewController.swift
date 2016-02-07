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
        
        let mainTitle = UILabel(frame: CGRectMake(50, 50, 200, 100))
        MainScreenHelper().setMainTitleText(mainTitle)
        mainView.addSubview(mainTitle)
        
        PtvApi().healthCheck({ (apiResponse, apiData) -> Void in

            mainTitle.text = "API Connection: "
            
            let apiDataJson = JSON(data: apiData!)
            
            mainView.addSubview(MainScreenHelper().arrangeOverallHealthCheckResultHeading())
            mainView.addSubview(MainScreenHelper().arrangeOverallHealthCheckResult(apiDataJson))
            MainScreenHelper().insertHealthCheckResults(apiDataJson, mainView: mainView)
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

