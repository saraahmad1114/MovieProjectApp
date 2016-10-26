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
    
    @IBOutlet weak var topLabel: UILabel!
    var plotMovieObject : Movie?

    @IBOutlet weak var plotLabelUpdated: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blackColor()
        self.plotLabelUpdated.textColor = UIColor.yellowColor()
        self.topLabel.textColor = UIColor.yellowColor()
        
        guard let unwrappedMovieObject = plotMovieObject else {print("ERROR OCCURRED HERE!"); return}
        
        self.store.getDescriptiveMovieFullPlotWith(unwrappedMovieObject) { (isWorking) in
            if isWorking
            {
                dispatch_async(dispatch_get_main_queue()){
                    print("THE CORRECT MOVIE IS PRINTINT OUT")
                    guard let unwrappedFullPlot = unwrappedMovieObject.fullPlot else {print("AN ERROR OCCURRED HERE!"); return}
                    self.plotLabelUpdated.text = unwrappedFullPlot
                }
            }
            else {
                print("AN ERROR OCCURRED HERE!")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation]

    // In a storyboard-based application, you will often want to do a little preparation before navigation


    
    


}
