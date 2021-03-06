//
//  ImageCollectionViewCell.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/12/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    let store = MovieDataStore.sharedInstance
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var imageInCell: UIImageView!
    

}
