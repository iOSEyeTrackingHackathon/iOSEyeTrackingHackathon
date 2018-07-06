//
//  DictionaryCell.swift
//  EyeTracking
//
//  Created by 양종열 on 2018. 7. 7..
//  Copyright © 2018년 hackathon. All rights reserved.
//

import UIKit

class DictionaryCell: UITableViewCell {
    @IBOutlet weak var wordText: UILabel!
    @IBOutlet weak var nounText: UILabel!
    @IBOutlet weak var verbText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
