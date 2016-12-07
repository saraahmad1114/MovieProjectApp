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
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet var pictureColl: UICollectionView!
    let store = MovieDataStore.sharedInstance
    var searchBar = UISearchBar()
    let movieSearchTerms = ["love", "fantasy", "romance", "mystery", "thriller", "musical", "family", "horror", "sci-fi", "Batman", "Star Wars", "Superman"]
    var randomNumber: UInt32 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.backgroundColor = UIColor.black
        self.searchBar.backgroundColor = UIColor.black
        navigationController!.navigationBar.barTintColor = UIColor.black
        self.navigationItem.titleView = self.searchBar;
        self.searchBar.delegate = self
        self.searchBar.placeholder = "BEGIN SEARCH HERE"
        randomNumber = arc4random_uniform(UInt32(self.movieSearchTerms.count))
        store.getMoviesWithCompletion(store.pageNum, query: self.movieSearchTerms[Int(randomNumber)]) { (movieArray) in
            OperationQueue.main.addOperation({
                self.collectionView?.reloadData()
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.store.movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        guard indexPath.row <= self.store.movies.count else { return cell }
        
        
        if let unwrappedPosterURL = store.movies[indexPath.row].posterURL {
            if unwrappedPosterURL == "N/A" {
                cell.imageInCell.image = UIImage.init(named: "star_PNG1592")
            }
            else {
                if let url = URL(string: unwrappedPosterURL) {
                if let data = try? Data(contentsOf: url) {
                    
                OperationQueue.main.addOperation({ 
                    cell.imageInCell.image = UIImage(data: data)
                })
                    }
                }
            }
        }
        if let movieTitle = store.movies[indexPath.row].title{
            cell.movieTitleLabel.textColor = UIColor.gray
            cell.movieTitleLabel.font = UIFont (name: "Georgia", size: 15)
            cell.movieTitleLabel.text = movieTitle
            
        }
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
         if indexPath.row == self.store.movies.count - 1
          {
                if searchBar.text == ""
                {
                    self.store.retrieveNextPageOfMovieInformation()
                    randomNumber = arc4random_uniform(UInt32(self.movieSearchTerms.count))
                    self.store.getMoviesWithCompletion(self.store.pageNum, query: self.movieSearchTerms[Int(randomNumber)], Completion: { (arrayFromSearchTerm) in
                        OperationQueue.main.addOperation({
                            self.collectionView?.reloadData()
                        })
                    })
                }
                else
                {
                    self.store.retrieveNextPageOfMovieInformation()
                    self.store.getMoviesWithCompletion(self.store.pageNum, query: searchBar.text!, Completion: { (array) in
                        OperationQueue.main.addOperation({
                            self.collectionView?.reloadData()
                        })
                        
                    })
            }
            
          }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.store.movies.removeAll()
        self.collectionView?.reloadData()
        self.store.getMoviesWithCompletion(store.pageNum, query: searchBar.text!) { (movieArray) in
            OperationQueue.main.addOperation({
                self.collectionView?.reloadData()
            })
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "descriptiveMovieInformation" {
            
        let destinationVC = segue.destination as? DetailViewController
        let path = pictureColl.indexPath(for: sender as! UICollectionViewCell)
        destinationVC?.movieObject = store.movies[(path?.row)!]
            
        }
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
