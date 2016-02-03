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
        
        
        
        let loadingText = UILabel(frame: CGRectMake(100, 100, 200, 100))
        loadingText.text = "Connecting to PTV API..."
        loadingText.font = UIFont.systemFontOfSize(16)
        loadingText.textColor = UIColor.blackColor()
        
        self.view.addSubview(loadingText)
        
        healthCheck({ (apiResponse) -> Void in
//            debugPrint(apiResponse.result)
//            debugPrint(apiResponse.result.value)

//            debugPrint(apiResponse.result.value)
            
            let json = JSON.parse(apiResponse.result.description)
            
            
            debugPrint(apiResponse.result.debugDescription)
            
//            debugPrint(apiResponse.description)
            
            
            loadingText.text = apiResponse.result.description
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

