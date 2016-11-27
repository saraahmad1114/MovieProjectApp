//
//  movieTrack.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 11/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class movieTrack{

    var trackName: String?
    var collectionName: String?
    var collectionNameCensored: String?
    var previewUrl: String?
    
    
    //designated initializer 
    init(trackName: String, collectionName: String, collectionNameCensored: String, previewUrl: String){
        
        self.trackName = trackName
        self.collectionName = collectionName
        self.collectionNameCensored = collectionNameCensored
        self.previewUrl = previewUrl
    }
    
    
    



}