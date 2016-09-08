//
//  FirstCollectionViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class FirstCollectionViewController: UICollectionViewController {
    
    let store = MovieDataStore.sharedInstance
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //return the number of sections
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in the section
        return store.movies.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //populating each of the cells with an image and converting the poster URLs to an image 
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FirstCollectionViewCell
        
        var url = store.movies[indexPath.row].posterURL
        
        var urls = NSURL(string: url)
        
        if let unwrappedURL = urls
        {
            var data = NSData(contentsOfURL: unwrappedURL)
            if let unwrappedData = data
            {
                cell.imageInCell.image = UIImage(data: unwrappedData)
            }
        }
        return cell
    }

}
