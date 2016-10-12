//
//  MovieTrailerViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 10/12/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class MovieTrailerViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var trailerWebView: UIWebView!
    var movieTrailerObject: Movie? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}