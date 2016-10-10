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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //tableView Stuff
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.movieSoundTrack.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("singleSoundTrack") as! MovieSoundTrackTableViewCellController
        cell.collectionNameLabel.text = self.store.movieSoundTrack[indexPath.row].collectionName
        cell.trackNameLabel.text = self.store.movieSoundTrack[indexPath.row].trackName
        
//        if let url = NSURL(string: unwrappedPosterURL) {
//            if let data = NSData(contentsOfURL: url) {
//                cell.imageInCell.image = UIImage(data: data)
//            }
//        }
//        guard let 
//        self.soundTrackMovieObject
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    
}
