//
//  MoviewTableViewCell.swift
//  RottenTomatoes
//
//  Created by Saket Agarwal on 9/15/14.
//  Copyright (c) 2014 Saket Agarwal. All rights reserved.
//

import UIKit

class MoviewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleThumbnail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
