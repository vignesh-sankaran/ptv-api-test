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
        
        PtvApi().newHealthCheck({ (apiData) -> Void in
            loadingText.text = "Random text shown here"
            print(NSString(data: apiData!, encoding: NSUTF8StringEncoding))
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

