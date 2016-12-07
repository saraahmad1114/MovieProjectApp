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
        
        titleLabel.textColor = UIColor.gray
        yearLabel.textColor = UIColor.gray
        directorLabel.textColor = UIColor.gray
        writersLabel.textColor = UIColor.gray
        actorsLabel.textColor = UIColor.gray
        shortPlotLabel.textColor = UIColor.gray
        typeLabel.textColor = UIColor.gray
        saveMovie.tintColor = UIColor.red
        fullPlot.tintColor = UIColor.red
       
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
        topImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        topImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.40).isActive = true
        topImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.30).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topImage.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 60).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60).isActive = true
        yearLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraint(equalTo: self.yearLabel.bottomAnchor, constant: 10).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60).isActive = true
        typeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        actorsLabel.translatesAutoresizingMaskIntoConstraints = false
        actorsLabel.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: 10).isActive = true
        actorsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60).isActive = true
        actorsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        writersLabel.translatesAutoresizingMaskIntoConstraints = false
        writersLabel.topAnchor.constraint(equalTo: self.actorsLabel.bottomAnchor, constant: 10).isActive = true
        writersLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70).isActive = true
        writersLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        directorLabel.topAnchor.constraint(equalTo: self.writersLabel.bottomAnchor, constant: 10).isActive = true
        directorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70).isActive = true
        directorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        shortPlotLabel.translatesAutoresizingMaskIntoConstraints = false
        shortPlotLabel.topAnchor.constraint(equalTo: self.directorLabel.bottomAnchor, constant: 10).isActive = true
        shortPlotLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70).isActive = true
        shortPlotLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        saveMovie.translatesAutoresizingMaskIntoConstraints = false
        saveMovie.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        saveMovie.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
       
        fullPlot.translatesAutoresizingMaskIntoConstraints = false
        fullPlot.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        fullPlot.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        self.store.getDescriptiveMovieInformationWith(unwrappedMovieObject) { (isWorking) in
            if isWorking {

                guard let unwrappedPosterURL = unwrappedMovieObject.posterURL else {print("AN ERROR OCCURRED HERE"); return}
                if unwrappedPosterURL == "N/A"{
                self.topImage.image = UIImage.init(named: "star_PNG1592")
                }
                else {
                    if let url = URL(string: unwrappedPosterURL){
                        if let data  = try? Data(contentsOf: url){
                            OperationQueue.main.addOperation({ 
                                self.topImage.image = UIImage.init(data: data)
                            })
                            }
                        }
                    }
                OperationQueue.main.addOperation({
                    self.titleLabel.text = unwrappedMovieObject.title
                    self.yearLabel.text = unwrappedMovieObject.year
                    self.typeLabel.text = unwrappedMovieObject.type
                    
                    self.navigationItem.title = unwrappedMovieObject.title
                    
                    guard let
                        unwrappedDirector = unwrappedMovieObject.director,
                        let unwrappedWriters = unwrappedMovieObject.writers,
                        let unwrappedActors = unwrappedMovieObject.actors,
                        let unwrappedShortPlot = unwrappedMovieObject.shortPlot
                        
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
    @IBAction func saveMovieTapped(_ sender: AnyObject) {
        
        guard let
            unwrappedMovieObject = self.movieObject else {print("movie object did not unwrap"); return}
        
        guard let
            unwrappedMovieTitle = unwrappedMovieObject.title,
            let unwrappedMovieYear = unwrappedMovieObject.year,
            let unwrappedMovieImdbRating = unwrappedMovieObject.imdbRating,
     
            let unwrappedMoviePosterURL = unwrappedMovieObject.posterURL
            
            else { print("AN ERROR OCCURRED HERE"); return}
        
        let entity = NSEntityDescription.entity(forEntityName: "CoreMovie", in: self.store.managedObjectContext)
        
        guard let unwrappedEntity = entity else {print("ENTITY DID NOT UNWRAP"); return}
        
        let coreMovieObject = CoreMovie.init(title: unwrappedMovieTitle, year: unwrappedMovieYear, imdbRating: unwrappedMovieImdbRating, entity: unwrappedEntity, posterURL: unwrappedMoviePosterURL, managedObjectContext: self.store.managedObjectContext)
        
        store.saveContext()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fullPlotSegue" {
            if let destinationVC = segue.destination as? PlotViewController {
                destinationVC.plotMovieObject = movieObject
            }
        }
    }

    


}
