//
//  SoundTrackViewController.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 10/7/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class SoundTrackViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let store = MovieDataStore.sharedInstance
    var soundTrackMovieObject: Movie?
    @IBOutlet weak var soundTrackTableView: UITableView!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.soundTrackTableView.delegate = self
        self.soundTrackTableView.dataSource = self
        
        guard let unwrappedMovieObject = self.soundTrackMovieObject else {print("ERROR OCCURRED HERE!"); return}
        
        store.movieSoundTrack.removeAll()
        store.getTracksOfMovieWith(unwrappedMovieObject) { (SoundTrackArray) in
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                self.soundTrackTableView.reloadData()
                print("*******************************")
                print(SoundTrackArray)
                print("*******************************")
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //tableView Stuff
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if store.movieSoundTrack.count == 0 {
            return 4
        }
        else {
        return self.store.movieSoundTrack.count
        }
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("singleSoundTrack") as! MovieSoundTrackTableViewCellController
        
        if let unwrappedCollectionName = store.movieSoundTrack[indexPath.row].collectionName{
            cell.collectionNameLabel.text = unwrappedCollectionName
        }
            if let unwrappedTracKName = store.movieSoundTrack[indexPath.row].trackName{
                cell.trackNameLabel.text = unwrappedTracKName
        }

        return cell
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        
    }
    

    
    
    
}
