//
//  VisitorsCellTableViewCell.swift
//  ios-interview
//
//  Created by Sandeep Penchala on 2/01/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

class VisitorsTableViewCell: UITableViewCell {
    @IBOutlet weak var visitorName: UILabel!

    @IBOutlet weak var visitingTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
