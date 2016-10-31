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

    @IBOutlet weak var fullPlotLabel: UILabel!
    
    @IBOutlet weak var actualPlot: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Untitled-2.jpg")!)
        self.actualPlot.textColor = UIColor.grayColor()
        self.fullPlotLabel.textColor = UIColor.grayColor()
        actualPlot.font = UIFont (name: "Georgia", size: 15)
        fullPlotLabel.font = UIFont (name: "Georgia", size: 15)
        
        guard let unwrappedMovieObject = plotMovieObject else {print("ERROR OCCURRED HERE!"); return}
        
        self.store.getDescriptiveMovieFullPlotWith(unwrappedMovieObject) { (isWorking) in
            if isWorking
            {
                dispatch_async(dispatch_get_main_queue()){
                    print("THE CORRECT MOVIE IS PRINTINT OUT")
                    guard let unwrappedFullPlot = unwrappedMovieObject.fullPlot else {print("AN ERROR OCCURRED HERE!"); return}
                    self.actualPlot.text = unwrappedFullPlot
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
