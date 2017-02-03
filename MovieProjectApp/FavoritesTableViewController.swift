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
        
        self.tableView.backgroundColor = UIColor.black
        store.fetchData()
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
        print("table count: \(self.store.favoriteMovies.count)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.fetchData()
        OperationQueue.main.addOperation {
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.favoriteMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//       let cell = tableView.dequeueReusableCell(withIdentifier: "meetupEventCell", for: indexPath) as! MeetupEventsDisplayTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! FavoritesCellTableViewCell
        cell.updateTitleLabel.textColor = UIColor.gray
        cell.updateYearLabel.textColor = UIColor.gray
        cell.updateimdbRatingLabel.textColor = UIColor.gray
        
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
    
            if let url = URL(string: neededURL){
                
                if let data = try? Data(contentsOf: url){
                    
                    cell.moviePicture.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let managedObjectContext = store.managedObjectContext
            managedObjectContext.delete(store.favoriteMovies[indexPath.row])

            store.favoriteMovies.remove(at: indexPath.row)
            store.saveContext()
            self.tableView.reloadData()
        }
    }

    //savedMovieDetails
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savedMovieDetail"
        {
//            let cell = sender as! UITableViewCell
//            guard let neededCell = self.tableView.indexPathForCell(cell) else {print("ERROR OCCURRED HERE"); return }
            
            //let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)

            if let unwrappedIndexPath = indexPath {
                
                guard let
                    neededTitle = self.store.favoriteMovies[unwrappedIndexPath.row].title,
                    let neededyear = self.store.favoriteMovies[unwrappedIndexPath.row].year,
                    let neededImdbRating = self.store.favoriteMovies[unwrappedIndexPath.row].imdbRating,
                    let neededPosterURL = self.store.favoriteMovies[unwrappedIndexPath.row].posterURL
                    
                    else {print("error"); return}
                
                let regularMovieObject = Movie.init(title: neededTitle, year: neededyear, imdbRating: neededImdbRating, posterURL: neededPosterURL)

                if let destinationVC = segue.destination as? DetailViewController{
                    destinationVC.movieObject = regularMovieObject
                }
            
            }
        }
    }
}
