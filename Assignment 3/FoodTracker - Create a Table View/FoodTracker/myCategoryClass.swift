//
//  myCategoryClass.swift
//  FoodTracker
//
//  Created by maya2016 on 2016-10-02.
//  Copyright © 2016 Apple Inc. All rights reserved.
//


import UIKit

class myCategoryClass {
    // MARK: Properties
    
    var name: String
    
    // MARK: Initialization
    
    init?(name: String) {
        // Initialize stored properties.
        self.name = name
        
        // Initialization should fail if there is no name or if the rating is negative.
    }
    
}
