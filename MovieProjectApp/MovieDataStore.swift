//
//  MovieDataStore.swift
//  OperatingMovieAppProject
//
//  Created by Flatiron School on 9/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class MovieDataStore
{
    
    static let sharedInstance = MovieDataStore()
    private init() {}
    
    var movies : [Movie] = []
    var pageNum = 1
    
    let movieSearchTerms = ["love", "fantasy", "romance", "mystery", "thriller", "musical", "family", "horror", "sci-fi", "Batman", "Star Wars", "Superman"]
    
    //First API Call
    func getMoviesWithCompletion(pageNum: Int, query: String, Completion: (NSArray) -> ())
    {
        OMDBAPIClient.getMovieResultsFromSearch(query, page: self.pageNum) { (arrayOfMovies) in
            for singleMovie in arrayOfMovies
            {
                let movieTitle = singleMovie["Title"] as? String
                let movieYear = singleMovie["Year"] as? String
                let movieImbdID = singleMovie["imdbID"] as? String
                let movieType = singleMovie["Type"] as? String
                let moviePosterURL = singleMovie["Poster"] as? String
                
                guard let
                    unwrappedMovieTitle = movieTitle,
                    unwrappedMovieYear = movieYear,
                    unwrappedMovieImbdID = movieImbdID,
                    unwrappedMovieType = movieType,
                    unwrappedMoviePosterURL = moviePosterURL
                
                    else {print("ERROR OCCURRED HERE!"); return}
                
                let singleMovieObject = Movie.init(title: unwrappedMovieTitle, year: unwrappedMovieYear, imdbID: unwrappedMovieImbdID, type: unwrappedMovieType, posterURL: unwrappedMoviePosterURL)
                
                print("****************************************")
                print("Movie Title: \(singleMovieObject.title)")
                print("Movie Year: \(singleMovieObject.year)")
                print("Movie ImdbID: \(singleMovieObject.imdbID)")
                print("Movie Type: \(singleMovieObject.type)")
                print("Movie PosterURL: \(singleMovieObject.posterURL)")
                print("****************************************")
                
                self.movies.append(singleMovieObject)
                print(self.movies.count)
            }

            Completion(self.movies)
        }
        
}
    //Second API Call
    func getDescriptiveMovieInformationWith(movie: Movie, Completion: (Bool) -> ())
    {
        OMDBAPIClient.getDescriptiveMovieResultsFromSearch(movie.imdbID) { (descriptiveResponseDictionary) in
            
            let desMovieDirector = descriptiveResponseDictionary["Director"] as? String
            let desMovieWriters = descriptiveResponseDictionary["Writer"] as? String
            let desMovieActors = descriptiveResponseDictionary["Actors"] as? String
            let desMovieShortPlot = descriptiveResponseDictionary["Plot"] as? String
            let desMovieimbdRating = descriptiveResponseDictionary["imdbRating"] as? String
            
            //unwrapping each of the of the json information
            guard let
                unwrappedDesMovieDirector = desMovieDirector,
                unwrappedDesMovieWriters = desMovieWriters,
                unwrappedDesMovieActors = desMovieActors,
                unwrappedDesMovieShortPlot = desMovieShortPlot,
                unwrappedDesMovieimbdRating = desMovieimbdRating
            
                else {print("AN ERROR OCCURRED HERE!"); return}
            
                movie.director = unwrappedDesMovieDirector
                movie.writers = unwrappedDesMovieWriters
                movie.actors = unwrappedDesMovieActors
                movie.shortPlot = unwrappedDesMovieShortPlot
                movie.imdbRating = unwrappedDesMovieimbdRating
        }
        
        Completion(true)
    }
    
    //Third API Call
    func getDescriptiveMovieFullPlotWith(movie: Movie, Completion: (Bool) -> ())
    {
        OMDBAPIClient.getMovieFullPlotWith(movie.imdbID) { (fullPlotMovieDictionary) in
            
            let movieFullPlot = fullPlotMovieDictionary["Plot"] as? String
            
            guard let
                
                unwrappedFullPlot = movieFullPlot
            
                else {print("AN ERROR OCCURRED HERE"); return}
            
                movie.fullPlot = unwrappedFullPlot
    
        }
        
        Completion(true)
        
        }
    
    //pagination Function
    func retrieveNextPageOfMovieInformation()
    {
        self.pageNum += 1
    }

    
}