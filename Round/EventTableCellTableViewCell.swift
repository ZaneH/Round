//
//  EventTableCellTableViewCell.swift
//  Round
//
//  Created by Skylar Thomas on 7/24/16.
//  Copyright © 2016 Round Dev Team. All rights reserved.
//

import UIKit

class EventTableCellTableViewCell: UITableViewCell {
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
