//
//  DetailViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let unwrappedMovieObject = movieObject
        else {print("AN ERROR OCCURRED HERE!"); return}
        self.store.getDescriptiveMovieInformationWith(unwrappedMovieObject, Completion: { (isWorking) in
            if isWorking
            {
            NSOperationQueue.mainQueue().addOperationWithBlock({
                print("This worked")
            
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

            })
            }
            else
            {
                print("An Error occured!")
            }
        })
            
        
    }

        
     

        
        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
