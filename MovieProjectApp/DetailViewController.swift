//
//  DetailViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    let store = MovieDataStore.sharedInstance
    var movieObject : Movie?
    var scrollView: UIScrollView!
    
    @IBOutlet weak var fullPlot: UIButton!
    @IBOutlet weak var saveMovie: UIButton!
    
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
        saveMovie.tintColor = UIColor.redColor()
        fullPlot.tintColor = UIColor.redColor()
       
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
        titleLabel.topAnchor.constraintEqualToAnchor(self.topImage.bottomAnchor, constant: 10).active = true
        titleLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor,constant: 60).active = true
        titleLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.topAnchor.constraintEqualToAnchor(self.titleLabel.bottomAnchor, constant: 10).active = true
        yearLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 60).active = true
        yearLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraintEqualToAnchor(self.yearLabel.bottomAnchor, constant: 10).active = true
        typeLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 60).active = true
        typeLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        actorsLabel.translatesAutoresizingMaskIntoConstraints = false
        actorsLabel.topAnchor.constraintEqualToAnchor(self.typeLabel.bottomAnchor, constant: 10).active = true
        actorsLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 60).active = true
        actorsLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        writersLabel.translatesAutoresizingMaskIntoConstraints = false
        writersLabel.topAnchor.constraintEqualToAnchor(self.actorsLabel.bottomAnchor, constant: 10).active = true
        writersLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 70).active = true
        writersLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        directorLabel.topAnchor.constraintEqualToAnchor(self.writersLabel.bottomAnchor, constant: 10).active = true
        directorLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 70).active = true
        directorLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        shortPlotLabel.translatesAutoresizingMaskIntoConstraints = false
        shortPlotLabel.topAnchor.constraintEqualToAnchor(self.directorLabel.bottomAnchor, constant: 10).active = true
        shortPlotLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 70).active = true
        shortPlotLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        saveMovie.translatesAutoresizingMaskIntoConstraints = false
        saveMovie.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 80).active = true
        saveMovie.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 10).active = true
       
        fullPlot.translatesAutoresizingMaskIntoConstraints = false
        fullPlot.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 80).active = true
        fullPlot.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor, constant: -20).active = true
        
        self.store.getDescriptiveMovieInformationWith(unwrappedMovieObject) { (isWorking) in
            if isWorking {

                guard let unwrappedPosterURL = unwrappedMovieObject.posterURL else {print("AN ERROR OCCURRED HERE"); return}
                if unwrappedPosterURL == "N/A"{
                self.topImage.image = UIImage.init(named: "star_PNG1592")
                }
                else {
                    if let url = NSURL(string: unwrappedPosterURL){
                        if let data  = NSData(contentsOfURL: url){
                            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                                self.topImage.image = UIImage.init(data: data)
                            })
                            }
                        }
                    }
                NSOperationQueue.mainQueue().addOperationWithBlock({
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

    //all changes occurred here!!!
    @IBAction func saveMovieTapped(sender: AnyObject) {
        
//        let savedMovieObject = NSEntityDescription.insertNewObjectForEntityForName("CoreMovie", inManagedObjectContext: store.managedObjectContext) as! CoreMovie
        
        guard let
            unwrappedMovieObject = self.movieObject else {print("movie object did not unwrap"); return}
        
        guard let
            unwrappedMovieTitle = unwrappedMovieObject.title,
            unwrappedMovieYear = unwrappedMovieObject.year,
            unwrappedMovieImdbRating = unwrappedMovieObject.imdbRating,
     
            unwrappedMoviePosterURL = unwrappedMovieObject.posterURL
            
            else { print("AN ERROR OCCURRED HERE"); return}
        
        let entity = NSEntityDescription.entityForName("CoreMovie", inManagedObjectContext: self.store.managedObjectContext)
        
        guard let unwrappedEntity = entity else {print("ENTITY DID NOT UNWRAP"); return}
        
        let coreMovieObject = CoreMovie.init(title: unwrappedMovieTitle, year: unwrappedMovieYear, imdbRating: unwrappedMovieImdbRating, entity: unwrappedEntity, posterURL: unwrappedMoviePosterURL, managedObjectContext: self.store.managedObjectContext)
        
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
