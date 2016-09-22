//
//  DetailViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    let store = MovieDataStore.sharedInstance
    var movieObject : Movie?
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var writersLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var shortPlotLabel: UILabel!
    @IBOutlet weak var imdbIDLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var stackViewLabel: UIStackView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        self.titleLabel.textColor = UIColor.yellowColor()
        self.yearLabel.textColor = UIColor.yellowColor()
        self.directorLabel.textColor = UIColor.yellowColor()
        self.writersLabel.textColor = UIColor.yellowColor()
        self.actorsLabel.textColor = UIColor.yellowColor()
        self.shortPlotLabel.textColor = UIColor.yellowColor()
        self.imdbIDLabel.textColor = UIColor.yellowColor()
        self.typeLabel.textColor = UIColor.yellowColor()
        self.imdbRating.textColor = UIColor.yellowColor()
       
        stackViewLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewLabel.topAnchor.constraintEqualToAnchor(self.topImage.bottomAnchor, constant: 5).active = true
        stackViewLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 1.00).active = true
        stackViewLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.50).active = true
        stackViewLabel.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        
        //unwrapped Movie Object
        guard let unwrappedMovieObject = movieObject
        else {print("AN ERROR OCCURRED HERE!"); return}
        
                NSOperationQueue.mainQueue().addOperationWithBlock({
            self.store.getDescriptiveMovieInformationWith(unwrappedMovieObject, Completion: { (isWorking) in
                if isWorking
                {
                    print("THE CORRECT MOVIE IS PRINTINT OUT")
                        
                    guard let unwrappedPosterURL = unwrappedMovieObject.posterURL else {print("AN ERROR OCCURRED HERE"); return}
                    
                    
                    
                        if let url = NSURL(string: unwrappedPosterURL)
                        {
                            if let data  = NSData(contentsOfURL: url)
                            {
                                print("I have an image to display")
                                self.topImage.image = UIImage.init(data: data)
                            }
                        }
                        self.titleLabel.text = unwrappedMovieObject.title
                        self.yearLabel.text = unwrappedMovieObject.year
                        self.imdbIDLabel.text = unwrappedMovieObject.imdbID
                        self.typeLabel.text = unwrappedMovieObject.type
                        
                        guard let
                            unwrappedDirector = unwrappedMovieObject.director,
                            unwrappedWriters = unwrappedMovieObject.writers,
                            unwrappedActors = unwrappedMovieObject.actors,
                            unwrappedShortPlot = unwrappedMovieObject.shortPlot,
                            unwrappedRating = unwrappedMovieObject.imdbRating
                            
                            else {print("PROPERTIES WERE UNWRAPPED"); return}
                        
                        self.directorLabel.text = unwrappedDirector
                        self.writersLabel.text = unwrappedWriters
                        self.actorsLabel.text = unwrappedActors
                        self.shortPlotLabel.text = unwrappedShortPlot
                        self.imdbRating.text = unwrappedRating
                }
                else
                {
                    print("An Error occured!")
                }
            })
        
        })
        
    }
        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveMovieTapped(sender: AnyObject) {

        let savedMovieObject = NSEntityDescription.insertNewObjectForEntityForName("Favorites", inManagedObjectContext: store.managedObjectContext) as! Favorites
        
        guard let unwrappedMovieObject = self.movieObject else{print("AN ERROR OCCURRED HERE"); return}
        savedMovieObject.movies?.insert(unwrappedMovieObject)
        
        store.saveContext()
//        print(savedMovieObject.movies)
//        print(store.favoriteMovies)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fullPlotSegue" {
            if let destinationVC = segue.destinationViewController as? PlotViewController {
                destinationVC.plotMovieObject = movieObject
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
