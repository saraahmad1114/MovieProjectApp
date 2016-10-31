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
    @IBOutlet weak var typeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Untitled-2.jpg")!)
        
        guard let unwrappedMovieObject = movieObject else {print("AN ERROR OCCURRED HERE!"); return}
        
        titleLabel.textColor = UIColor.grayColor()
        yearLabel.textColor = UIColor.grayColor()
        directorLabel.textColor = UIColor.grayColor()
        writersLabel.textColor = UIColor.grayColor()
        actorsLabel.textColor = UIColor.grayColor()
        shortPlotLabel.textColor = UIColor.grayColor()
        typeLabel.textColor = UIColor.grayColor()
       
        titleLabel.font = UIFont (name: "Georgia", size: 15)
        yearLabel.font = UIFont (name: "Georgia", size: 15)
        directorLabel.font = UIFont (name: "Georgia", size: 15)
        writersLabel.font = UIFont (name: "Georgia", size: 15)
        actorsLabel.font = UIFont (name: "Georgia", size: 15)
        shortPlotLabel.font = UIFont (name: "Georgia", size: 15)
        typeLabel.font = UIFont (name: "Georgia", size: 15)

        //Constraints
        view.removeConstraints(view.constraints)
        topImage.translatesAutoresizingMaskIntoConstraints = false
        topImage.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 80).active = true
        topImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        topImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.40).active = true
        topImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.30).active = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraintEqualToAnchor(self.topImage.topAnchor, constant: 240).active = true
        titleLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor,constant: 50).active = true
        titleLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true 
        
        self.store.getDescriptiveMovieInformationWith(unwrappedMovieObject) { (isWorking) in
            if isWorking {

                NSOperationQueue.mainQueue().addOperationWithBlock({
                guard let unwrappedPosterURL = unwrappedMovieObject.posterURL else {print("AN ERROR OCCURRED HERE"); return}
                if unwrappedPosterURL == "N/A"{
                self.topImage.image = UIImage.init(named: "star_PNG1592")
                }
                else {
                    if let url = NSURL(string: unwrappedPosterURL){
                        if let data  = NSData(contentsOfURL: url){
                            self.topImage.image = UIImage.init(data: data)
                            }
                        }
                    }
                    self.titleLabel.text = unwrappedMovieObject.title
                    self.yearLabel.text = unwrappedMovieObject.year
                    self.typeLabel.text = unwrappedMovieObject.type
                    
                    self.navigationItem.title = unwrappedMovieObject.title
                    
                    guard let
                        unwrappedDirector = unwrappedMovieObject.director,
                        unwrappedWriters = unwrappedMovieObject.writers,
                        unwrappedActors = unwrappedMovieObject.actors,
                        unwrappedShortPlot = unwrappedMovieObject.shortPlot
                        
                    else {print("PROPERTIES WERE UNWRAPPED"); return}
                    
                        self.directorLabel.text = unwrappedDirector
                        self.writersLabel.text = unwrappedWriters
                        self.actorsLabel.text = unwrappedActors
                        self.shortPlotLabel.text = unwrappedShortPlot
                })
            }
            else{
                
                print("AN ERROR OCCURRED HERE")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveMovieTapped(sender: AnyObject) {
        
        let savedMovieObject = NSEntityDescription.insertNewObjectForEntityForName("Favorites", inManagedObjectContext: store.managedObjectContext) as! Favorites
        
        guard let unwrappedMovieObject = self.movieObject else { print("AN ERROR OCCURRED HERE"); return}
        
        savedMovieObject.movies?.insert(unwrappedMovieObject)
        store.saveContext()

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fullPlotSegue" {
            if let destinationVC = segue.destinationViewController as? PlotViewController {
                destinationVC.plotMovieObject = movieObject
            }
        }
    }

    


}
