//
//  PairTableViewCell.swift
//  PairListBtc
//
//  Created by İbrahim Demirci on 8.12.2021.
//

import UIKit

class PairTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var numeratorText: UILabel!
    
    @IBOutlet weak var fullNameText: UILabel!
    @IBOutlet weak var lastText: UILabel!
    
    @IBOutlet weak var dailyPercentText: UILabel!
    
    @IBOutlet weak var volumeText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dailyPercentText.layer.masksToBounds = true
        dailyPercentText.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
