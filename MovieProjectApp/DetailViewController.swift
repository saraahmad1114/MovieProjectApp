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
        
//        if let url = NSURL(string: self.store.movies[indexPath.row].posterURL) {
//            if let data = NSData(contentsOfURL: url) {
//                //ImageCollectionViewCell.imageInCell.image = UIImage(data: data)
//                cell.imageInCell.image = UIImage(data: data)
        
//        if let url = NSURL(string: unwra.posterURL)
//        {
//            if let data = NSData(contentsOfURL: url)
//            {
//            }
//        }
        
        guard let unwrappedMovieObject = movieObject
        else {print("AN ERROR OCCURRED HERE!"); return}
        self.store.getDescriptiveMovieInformationWith(unwrappedMovieObject, Completion: { (isWorking) in
            if isWorking
            {
            NSOperationQueue.mainQueue().addOperationWithBlock({
                print("THE CORRECT MOVIE IS PRINTINT OUT")
            
                guard let unwrappedPosterURL = unwrappedMovieObject.posterURL else {print("AN ERROR OCCURRED HERE"); return}
                
                if let url = NSURL(string: unwrappedPosterURL)
                {
                    if let data = NSData(contentsOfURL: url)
                    {
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
    
    
    @IBAction func fullPlotButtonTapped(sender: AnyObject) {
        
//        if segue.identifier == "fullPlotSegue" {
////            if let destinationVC = segue.destinationViewController as?
//        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "fullPlotSegue" {
            if let destinationVC = segue.destinationViewController as? PlotViewController
            {
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
