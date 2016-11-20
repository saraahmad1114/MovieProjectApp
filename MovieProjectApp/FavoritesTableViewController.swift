//
//  FavoritesTableViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    let store = MovieDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.blackColor()
        store.fetchData()
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.tableView.reloadData()
        }
        print("table count: \(self.store.favoriteMovies.count)")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        store.fetchData()
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.tableView.reloadData()
            print("********************************")
            print(self.store.favoriteMovies.count)
            print("********************************")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.favoriteMovies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! FavoritesCellTableViewCell
        
        cell.updateTitleLabel.textColor = UIColor.grayColor()
        cell.updateYearLabel.textColor = UIColor.grayColor()
        cell.updateimdbRatingLabel.textColor = UIColor.grayColor()
        
        cell.updateTitleLabel.font = UIFont (name: "Georgia", size: 15)
        cell.updateYearLabel.font = UIFont (name: "Georgia", size: 15)
        cell.updateimdbRatingLabel.font = UIFont (name: "Georgia", size: 15)
        
 
        if let movieTitle = self.store.favoriteMovies[indexPath.row].title {
            
            cell.updateTitleLabel.text = movieTitle
        }
            if let movieYear = self.store.favoriteMovies[indexPath.row].year {
                
                cell.updateYearLabel.text = movieYear
            }
        
                if let movieimdbRating = self.store.favoriteMovies[indexPath.row].imdbRating{
            
                    cell.updateimdbRatingLabel.text = movieimdbRating
                }
        
        if let neededURL = self.store.favoriteMovies[indexPath.row].posterURL{
    
            if let url = NSURL(string: neededURL){
                
                if let data = NSData(contentsOfURL: url){
                    
                    cell.moviePicture.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            let managedObjectContext = store.managedObjectContext
            managedObjectContext.deleteObject(store.favoriteMovies[indexPath.row])

            store.favoriteMovies.removeAtIndex(indexPath.row)
            store.saveContext()
            self.tableView.reloadData()
        }
    }

    //savedMovieDetails
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "savedMovieDetail"
        {
//            let cell = sender as! UITableViewCell
//            guard let neededCell = self.tableView.indexPathForCell(cell) else {print("ERROR OCCURRED HERE"); return }
            
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)

            //let tabCell = self.store.favoriteMovies[neededCell.row]
            guard let unwrappedIndexPath = indexPath else {print("error occurred here"); return}
                
                guard let
                    neededTitle = self.store.favoriteMovies[unwrappedIndexPath.row].title,
                    neededyear = self.store.favoriteMovies[unwrappedIndexPath.row].year,
                    neededImdbRating = self.store.favoriteMovies[unwrappedIndexPath.row].imdbRating,
                    neededPosterURL = self.store.favoriteMovies[unwrappedIndexPath.row].posterURL
                    
                    else {print("error"); return}
                
                let regularMovieObject = Movie.init(title: neededTitle, year: neededyear, imdbRating: neededImdbRating, posterURL: neededPosterURL)

                if let destinationVC = segue.destinationViewController as? DetailViewController{
                    destinationVC.movieObject = regularMovieObject
                }
            
            }
        
    }
    
}
