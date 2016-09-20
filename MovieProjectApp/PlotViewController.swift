//
//  PlotViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class PlotViewController: UIViewController {
    
    let store = MovieDataStore.sharedInstance
    
    var plotMovieObject : Movie?

    @IBOutlet weak var plotLabelUpdated: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blackColor()
        self.plotLabelUpdated.textColor = UIColor.yellowColor()
        
        guard let unwrappedMovieObject = plotMovieObject else {print("ERROR OCCURRED HERE!"); return}
        
        self.store.getDescriptiveMovieFullPlotWith(unwrappedMovieObject) { (isWorking) in
            if isWorking
            {
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    print("THE CORRECT MOVIE IS PRINTINT OUT")
                    
                    guard let unwrappedFullPlot = unwrappedMovieObject.fullPlot else {print("AN ERROR OCCURRED HERE!"); return}
                    
                    self.plotLabelUpdated.text = unwrappedFullPlot
                     })
                 }
        }
        
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
    
    
//    convenience init(title: String, year: String, type: String, imdbID: String, posterURL: String, entity: NSEntityDescription, managedObjectContext: NSManagedObjectContext)
//    {
//        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
//        self.title = title
//        self.year = year
//        //        self.type = type
//        self.imdbID = imdbID
//        self.posterURL = posterURL
//    }

}
