//
//  FavoritesCellTableViewCell.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class FavoritesCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var moviePicture: UIImageView!
    @IBOutlet weak var updateTitleLabel: UILabel!
    
    @IBOutlet weak var updateYearLabel: UILabel!
    
    @IBOutlet weak var updateimdbRatingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
//        label.center = CGPointMake(160, 284)
//        label.textAlignment = NSTextAlignment.Center
////        label.text = "I'am a test label"
//        self.tableView.addSubview(label)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
