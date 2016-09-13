//
//  CollectionViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var imageInsideCell: UIImageView!
        
    let store = MovieDataStore.sharedInstance
    var searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        self.navigationItem.titleView = self.searchBar;
        self.searchBar.delegate = self
        self.searchBar.placeholder = "BEGIN SEARCH HERE"
        
//        The Second API call works fine!
//        OMDBAPIClient.getDescriptiveMovieResultsFromSearch("tt2488496") { (descriptiveDictionary) in
//            print("***************************")
//            print(descriptiveDictionary)
//            print("***************************\n\n")
//        }
//        The Second Function from the DataStore works just fine!
//        store.getDescriptiveMovieInformationWith { (descriptiveArray) in
//            print("***************************")
//            print(descriptiveArray)
//            print("***************************")
//        }
//       The third API Call works fine!
//        OMDBAPIClient.getMovieFullPlotWith("tt2488496") { (descriptiveDictionary) in
//            print("***************************")
//            print(descriptiveDictionary)
//            print("***************************\n\n")
//        }
        
        store.getDescriptiveMovieFullPlotWith { (descriptiveArray) in
            print("***************************")
            print(descriptiveArray)
            print("***************************")
        }
        
        
        store.getMoviesWithCompletion {_ in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                print("This worked!")
                self.collectionView?.reloadData()
            })
        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.store.movies.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
//        cell.backgroundColor = UIColor.redColor()
        
        //print("CELLLLLLL STUFFFFFF!!!")
        
//        NSOperationQueue.mainQueue().addOperationWithBlock({
//            print("This worked!")
//            self.collectionView?.reloadData()
        //})
        
        if let url = NSURL(string: self.store.movies[indexPath.row].posterURL) {
            if let data = NSData(contentsOfURL: url) {
               //ImageCollectionViewCell.imageInCell.image = UIImage(data: data)
                cell.imageInCell.image = UIImage(data: data)
            }        
        }
        
//          })
        
//        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
//        
//        var url = self.store.movies[indexPath.row].posterURL
//        
//        var urls = NSURL(string: url)
//        
//        guard let unwrappedURL = urls else {print("AN ERROR OCCURRED HERE")}
//        
//        var data = NSData(contentsOfURL: unwrappedURL)
//        
//        self.imageInsideCell.sd.setImageWithURL(data, completed: block)
//        if let url = NSURL(string: self.store[indexPath.row].posterURL) {
//            if let data = NSData(contentsOfURL: url){
//                cell.imageInsideCell.contentMode = UIViewContentMode.ScaleAspectFit
//                cell.imageInsideCell = UIImage(data: data)
//            }
//        }
//
        return cell
    }
    
    //search button works! 
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        OMDBAPIClient.getMovieResultsFromSearch(searchBar.text!) { (arrayOfDictonaries) in
            print(arrayOfDictonaries)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

