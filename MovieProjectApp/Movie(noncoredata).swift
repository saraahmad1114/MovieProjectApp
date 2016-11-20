//////
//////  Movie.swift
//////  OperatingMovieAppProject
//////
//////  Created by Flatiron School on 9/9/16.
//////  Copyright © 2016 Flatiron School. All rights reserved.
//////
////
import Foundation

class Movie
{
    var title: String?
    var year: String?
    var director: String?
    var writers: String?
    var actors: String?
    var fullPlot: String?
    var shortPlot: String?
    var imdbID: String?
    var type: String?
    var imdbRating: String?
    var posterURL: String?
    
    //designated initializer
   init( title: String, year: String, director: String, writers: String, actors: String, fullPlot: String, shortPlot: String, imdbID: String, type: String, imdbRating: String, posterURL: String)
    {
        
        self.title = title
        self.year = year
        self.director = director
        self.writers = writers
        self.actors = actors
        self.fullPlot = fullPlot
        self.shortPlot = shortPlot
        self.imdbID = imdbID
        self.type = type
        self.imdbRating = imdbRating
        self.posterURL = posterURL
    }
    
    //convenience initializer
    convenience init (title: String, year: String, imdbID: String, type: String, posterURL: String)
    {
        self.init(title: title, year: year, director: "NOT FOUND", writers: "NOT FOUND", actors: "NOT FOUND", fullPlot: "NOT FOUND", shortPlot: "NOT FOUND", imdbID: imdbID, type: type, imdbRating: "NOT FOUND", posterURL: posterURL)
    }
    
    
    convenience init (title: String, year: String, imdbRating: String, posterURL: String){
    
        self.init(title: title, year: year, director: "NOT FOUND", writers: "NOT FOUND", actors: "NOT FOUND", fullPlot: "NOT FOUND", shortPlot: "NOT FOUND", imdbID: "NOT FOUND", type: "NOT FOUND", imdbRating: imdbRating, posterURL: posterURL)
    }
}
