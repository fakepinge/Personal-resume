//
//  ExperienceTableViewCell.swift
//  resume
//
//  Created by 胡知平 on 16/6/26.
//  Copyright © 2016年 胡知平. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var oneTimeLabel: UILabel!
    @IBOutlet weak var oneCompanyLabel: UILabel!
    @IBOutlet weak var secondTimeLabel: UILabel!
    
    @IBOutlet weak var secondCompanyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
