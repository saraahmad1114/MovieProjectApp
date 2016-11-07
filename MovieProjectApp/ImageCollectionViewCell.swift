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
    
//        class func populatingCollectionViewCell() {
//}

//        let indexPath: NSIndexPath
//        
//        let cell = CollectionViewController.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCollectionViewCell
//        
//        guard indexPath.row <= self.store.movies.count else { return cell }
//        
//        if let unwrappedPosterURL = self.store.movies[indexPath.row].posterURL {
//            if unwrappedPosterURL == "N/A" {
//                cell.imageInCell.image = UIImage.init(named: "star_PNG1592")
//            }
//            else {
//                if let url = NSURL(string: unwrappedPosterURL) {
//                    if let data = NSData(contentsOfURL: url) {
//                        NSOperationQueue.mainQueue().addOperationWithBlock({ 
//                            cell.imageInCell.image = UIImage(data: data)
//                        })
//
//                    }
//                }
//            }
//        }
//        if let movieTitle = self.store.movies[indexPath.row].title{
//            cell.movieTitleLabel.textColor = UIColor.grayColor()
//            cell.movieTitleLabel.font = UIFont (name: "Georgia", size: 15)
//            cell.movieTitleLabel.text = movieTitle
//            
//        }
//        
//    
//    }
}
