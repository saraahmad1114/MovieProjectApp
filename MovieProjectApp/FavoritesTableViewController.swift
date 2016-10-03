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
        
        store.fetchData()
        NSOperationQueue.mainQueue().addOperationWithBlock { 
            self.tableView.reloadData()
        }

        print("table count: \(self.store.favoriteMovies.count)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.store.favoriteMovies.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("trying to make a table view")
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! FavoritesCellTableViewCell
    
        let favoritesIndex = self.store.favoriteMovies[indexPath.row]
        print("favorites table view count \(self.store.favoriteMovies.count)")
        
        if let url = NSURL(string: (favoritesIndex.posterURL)!)
        {
            if let data = NSData(contentsOfURL: url)
            {
                cell.moviePicture.image = UIImage.init(data: data)
            }
        }
        
        cell.updateYearLabel.text = favoritesIndex.year
        cell.updateTitleLabel.text = favoritesIndex.title
        cell.updateimdbRatingLabel.text = favoritesIndex.imdbRating

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "savedMovieDetails"
        {
            let cell = sender as! UITableViewCell
            
            guard let neededCell = self.tableView.indexPathForCell(cell) else {print("ERROR OCCURRED HERE"); return }
            
            let indexPath: NSIndexPath = neededCell
            let destinationVC = segue.destinationViewController as? DetailViewController
            destinationVC!.movieObject = self.store.favoriteMovies[neededCell.row]
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
