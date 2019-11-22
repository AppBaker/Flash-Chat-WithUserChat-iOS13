//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Ivan Nikitin on 18.11.2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var boobleMessage: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var youAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boobleMessage.layer.cornerRadius = boobleMessage.frame.height / 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
