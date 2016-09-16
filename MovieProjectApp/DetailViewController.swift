//
//  DetailViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var movieObject : Movie?
    
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

        
        guard let
            
        unwarppedMovieObject = movieObject
        
        else {print("AN ERROR OCCURRED HERE!"); return}
        
        self.titleLabel.text = unwarppedMovieObject.title
        self.yearLabel.text = unwarppedMovieObject.year
        self.directorLabel.text = unwarppedMovieObject.director
        self.writersLabel.text = unwarppedMovieObject.writers
        self.actorsLabel.text = unwarppedMovieObject.actors
        self.shortPlotLabel.text = unwarppedMovieObject.shortPlot
        self.imdbIDLabel.text = unwarppedMovieObject.imdbID
        self.typeLabel.text = unwarppedMovieObject.type
        self.imdbRating.text = unwarppedMovieObject.imdbRating
        
        //TOPIMAGE
        //setting the constraints Programmatically for each of the elements on the view controller
//        topImage.translatesAutoresizingMaskIntoConstraints = false
//        //getting rid of all the constraints
//        topImage.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
//        //setting the topAnchor constraint to the top of the self.view 
//        topImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
//        //setting the image to be in the center of the view controller 
//        topImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.33).active = true
//        //setting the height of the image in relation to the entire view of the controller 
//        topImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 1.00).active = true
        
        

        
        // Do any additional setup after loading the view.
    }

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
