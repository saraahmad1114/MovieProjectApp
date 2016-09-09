//
//  Movie.swift
//  OperatingMovieAppProject
//
//  Created by Flatiron School on 9/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class Movie
{
    let title: String
    let year: String
    let director: String?
    let writer: String?
    let actors: [String]?
    let fullPlot: String?
    let shortPlot: String?
    let imdbID: String
    let type: String
    let imdbRating: String?
    let posterURL: String
    
    //designated initializer
    init(title: String, year: String, director: String, writer: String, actors: [String], fullPlort: String, shortPlot: String, imdbID: String, type: String, imdbRating: String, posterURL: String)
    {
        self.title = title
        self.year = year
        self.director = director
        self.writer = writer
        self.actors = actors
        self.fullPlot = fullPlort
        self.shortPlot = shortPlot
        self.imdbID = imdbID
        self.type = type
        self.imdbRating = imdbRating
        self.posterURL = posterURL
    }
    
    //convenience initializer
    convenience init (title: String, year: String, imdbID: String, type: String, posterURL: String)
    {
        self.init(title: title, year: year, director: "NOT FOUND", writer: "NOT FOUND", actors: [], fullPlort: "NOT FOUND", shortPlot: "NOT FOUND", imdbID: imdbID, type: type, imdbRating: "NOT FOUND", posterURL: posterURL)
    }

}
