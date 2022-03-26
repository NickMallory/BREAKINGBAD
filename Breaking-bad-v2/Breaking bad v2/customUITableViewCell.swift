//
//  customUITableViewCell.swift
//  breaking bad project
//
//  Created by Nick Chiloane on 2021/07/10.
//

import UIKit

class customUITableViewCell: UITableViewCell {


    @IBOutlet weak var actorImg: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var actorNickname: UILabel!
    
    @IBOutlet weak var actorName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
