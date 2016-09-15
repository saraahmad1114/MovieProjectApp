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
    
    let store = MovieDataStore.sharedInstance
    var searchBar = UISearchBar()
    let movieSearchTerms = ["love", "fantasy", "romance", "mystery", "thriller", "musical", "family", "horror", "sci-fi", "Batman", "Star Wars", "Superman"]
    var randomNumber: UInt32 = 0
    var searchActive : Bool = true
    
    //function begins here!!!!!!!!!!!!!!!!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        self.navigationItem.titleView = self.searchBar;
        self.searchBar.delegate = self
        self.searchBar.placeholder = "BEGIN SEARCH HERE"

        
        print("SEARCH BEGINS HERE INITIALLY")
        randomNumber = arc4random_uniform(UInt32(self.movieSearchTerms.count))
        store.getMoviesWithCompletion(store.pageNum, query: self.movieSearchTerms[Int(randomNumber)]) { (movieArray) in
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                print("This worked")
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
        
        guard indexPath.row <= self.store.movies.count else { return cell }
        
        if let url = NSURL(string: self.store.movies[indexPath.row].posterURL) {
            if let data = NSData(contentsOfURL: url) {
               //ImageCollectionViewCell.imageInCell.image = UIImage(data: data)
                cell.imageInCell.image = UIImage(data: data)
            }        
        }

        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath)
    {
          if indexPath.row == self.store.movies.count - 1
          {
                if searchBar.text == ""
                {
                    self.store.retrieveNextPageOfMovieInformation()
                    randomNumber = arc4random_uniform(UInt32(self.movieSearchTerms.count))
                    self.store.getMoviesWithCompletion(self.store.pageNum, query: self.movieSearchTerms[Int(randomNumber)], Completion: { (arrayFromSearchTerm) in
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            self.collectionView?.reloadData()
                        })
                    })
                }
                else
                {
                    self.store.retrieveNextPageOfMovieInformation()
                    self.store.getMoviesWithCompletion(self.store.pageNum, query: searchBar.text!, Completion: { (array) in
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            self.collectionView?.reloadData()
                        })
                        
                    })
            }
            
          }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("SEARCH BUTTON WAS TAPPED")
        self.store.movies.removeAll()
        self.collectionView?.reloadData()
        self.store.getMoviesWithCompletion(store.pageNum, query: searchBar.text!) { (movieArray) in
            print("*********************************")
            print(movieArray)
            print("*********************************")
            NSOperationQueue.mainQueue().addOperationWithBlock({
                print("the movies are \(self.store.movies.count)")
                self.collectionView?.reloadData()
            })
        }
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    //search button works! 
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        self.store.retrieveNextPageOfMovieInformation(self.store.pageNum)
//
//        OMDBAPIClient.getMovieResultsFromSearch(searchBar.text!, page: store.pageNum) { (arrayOfDictionaries) in
//            self.store.retrieveNextPageOfMovieInformation(self.store.pageNum)
//            OMDBAPIClient.getMovieResultsFromSearch(searchBar.text!, page: self.store.pageNum, completion: { (nextArrayOfDictionaries) in
//                print("*******************************")
//                print(nextArrayOfDictionaries)
//                print("*******************************")
//            })
        //}
        //self.store.retrieveNextPageOfMovieInformation()
//        self.store.movies.removeAll()
//        self.store.retrieveNextPageOfMovieInformation()
//        self.store.getMoviesWithCompletion(self.store.pageNum) { (newArrayOfMovies) in
//            print("This worked!")
//        }
//        OMDBAPIClient.getMovieResultsFromSearch(searchBar.text!, page: self.store.pageNum) { (arrayOfDictionaries) in
//            print("*********************************")
//            print(arrayOfDictionaries)
//            print("*********************************")
//self.collectionView!.deleteItemsAtIndexPaths([indexPath])
//
//        store.movies.removeAll()
//        store.getMoviesWithCompletion(store.pageNum, query: searchBar.text!) { (arrayOfDictionaries) in
//            print("*********************************")
//            print(arrayOfDictionaries)
//            print("*********************************")
////            NSOperationQueue.mainQueue().addOperationWithBlock({
////                self.collectionView?.reloadData()
////            })
//        }
//        
//    }
    

//



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
