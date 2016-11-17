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
        
        let neededCell = self.store.favoriteMovies[indexPath.row]
            
        if let neededTitle = neededCell.movies?.first {
            cell.updateTitleLabel.text = neededTitle.title
            cell.updateYearLabel.text = neededCell.movies!.first!.year
            cell.updateimdbRatingLabel.text = neededCell.movies!.first!.imdbRating
        }
        
        if let neededURL = neededCell.movies?.first?.posterURL{
            
            if let url = NSURL(string: (neededURL)){
                
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
        if segue.identifier == "savedMovieDetails"
        {
            let cell = sender as! UITableViewCell

            guard let neededCell = self.tableView.indexPathForCell(cell) else {print("ERROR OCCURRED HERE"); return }

            let indexPath: NSIndexPath = neededCell
            let destinationVC = segue.destinationViewController as? DetailViewController
//            destinationVC!.movieObject = self.store.favoriteMovies[neededCell.row].movies.first
        }
        
    }
    
}
