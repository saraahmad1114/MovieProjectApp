//
//  MovieSoundTrack.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 10/6/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class MovieSoundTrack
{
    var collectionName: String?
    var trackName: String?
    var previewURL: String?
    var trackCount: Int?
    
    //designated Initializer 
    init(collectionName: String, trackName: String, previewURL: String, trackCount: Int)
        
    {
        self.collectionName = collectionName
        self.trackName = trackName
        self.previewURL = previewURL
        self.trackCount = trackCount
    }

}