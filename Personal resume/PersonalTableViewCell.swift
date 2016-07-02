//
//  PersonalTableViewCell.swift
//  Personal resume
//
//  Created by 胡知平 on 16/6/26.
//  Copyright © 2016年 fengli. All rights reserved.
//

import UIKit

class PersonalTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var workTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
