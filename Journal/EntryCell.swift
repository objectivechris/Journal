//
//  EntryCell.swift
//  Journal
//
//  Created by Christopher Rene on 4/26/17.
//  Copyright © 2017 Christopher Rene. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
