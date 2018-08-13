//
//  MainDisplayTableViewCell.swift
//  RTO App Project
//
//  Created by Ajinkya Sonar on 18/07/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class MainDisplayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DisplayImage: UIImageView!
    @IBOutlet weak var DisplayTitle: UILabel!
    @IBOutlet weak var DisplayInfo: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
