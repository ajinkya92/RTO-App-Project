//
//  QuestionBankImageCell.swift
//  RTO App Project
//
//  Created by Ajinkya Sonar on 20/07/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class QuestionBankImageCell: UITableViewCell {
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var displayImageText: UILabel!
    @IBOutlet weak var backgroundCardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateUI()
    }
    
    func updateUI() {
        
        backgroundCardView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(displayP3Red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        
        backgroundCardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
