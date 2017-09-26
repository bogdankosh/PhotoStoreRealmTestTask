//
//  InterfaceController.swift
//  PhotoStore Extension
//
//  Created by Bogdan Koshyrets on 9/25/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBAction func buttonButton() {
        print("Button pressed")
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
