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
    let store = MovieDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwrappedMovie = movieTrailerObject else {print("ERROR OCCURRED HERE"); return}
        
        
        store.getMovieTrailerWith(unwrappedMovie) { (movieTrailer) in
        
        let videoSizing: String = "<!DOCTYPE html><html><head><style>body{margin:0px 0px 0px 0px;}</style></head> <body> <div id=\"player\"></div> <script> var tag = document.createElement('script'); tag.src = \"http://www.youtube.com/player_api\"; var firstScriptTag = document.getElementsByTagName('script')[0]; firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); var player; function onYouTubePlayerAPIReady() { player = new YT.Player('player', { width:'%0.0f', height:'%0.0f', videoId:'%@', events: { 'onReady': onPlayerReady, } }); } function onPlayerReady(event) { event.target.playVideo(); } </script> </body> </html>"
        
            guard let unwrappedMovieKey = movieTrailer.movieKey else {print("ERROR OCCURRED HERE"); return}
            
            let html: String = String(format: videoSizing, self.trailerWebView.frame.size.width, self.trailerWebView.frame.size.height, unwrappedMovieKey)
        
            self.trailerWebView.loadHTMLString(html, baseURL: nil)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}