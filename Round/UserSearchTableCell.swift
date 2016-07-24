//
//  UserSearchTableCell.swift
//  round
//
//  Created by Skylar Thomas on 6/25/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse

protocol FriendSearchTableViewCellDelegate: class {
    func cell(cell: UserSearchTableCell, didSelectFollowUser user: PFUser)
    func cell(cell: UserSearchTableCell, didSelectUnfollowUser user: PFUser)
}


class UserSearchTableCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var personLabel: UILabel!
    @IBOutlet var creatorImg: UIImageView!
    
    weak var delegate: FriendSearchTableViewCellDelegate?
    
    var location: PFObject? {
        
        /*var first = String(user!["firstName"])
         var last = String (user!["lastName"])*/
        
        didSet {
            name.text = "\(location!["Name"])"
            dateLabel.text = "June 14, 2014"
            timeLabel.text = "10:00 am"
            personLabel.text = "\(location!["creatorName"])"

        }
    }
    
    var canFollow: Bool? = true {
        didSet {
            /*
             Change the state of the follow button based on whether or not
             it is possible to follow a user.
             */
            /*if let canFollow = canFollow {
             settingsBtn.selected = !canFollow
             }*/
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        //        var tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("cellTapped:"))
        //        self.userInteractionEnabled = true
        //        self.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
