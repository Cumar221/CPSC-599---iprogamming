//
//  CategoryTableViewCell.swift
//  FoodTracker
//
//  Created by maya2016 on 2016-10-02.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var catLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
	