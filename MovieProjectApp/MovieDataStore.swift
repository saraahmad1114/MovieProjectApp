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
    var descriptiveMovieArray : [Movie] = []
    var descriptiveMovieFullPlotArray :[Movie] = []
    var pageNum = 1
    
    let movieSearchTerms = ["love", "fantasy", "romance", "mystery", "thriller", "musical", "family", "horror", "sci-fi", "Batman", "Star Wars", "Superman"]
    
    //First API Call
    // 1
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
    func getDescriptiveMovieInformationWith(movie: Movie, Completion: (__Reply__act_get_state_t) -> ())
    {
        OMDBAPIClient.getDescriptiveMovieResultsFromSearch(movie.imdbID) { (descriptiveResponseDictionary) in
            
            //casting the information from the json dictionary correctly
            let desMovieTitle = descriptiveResponseDictionary["Title"] as? String
            let desMovieYear = descriptiveResponseDictionary["Year"] as? String
            let desMovieDirector = descriptiveResponseDictionary["Director"] as? String
            let desMovieWriters = descriptiveResponseDictionary["Writer"] as? String
            let desMovieActors = descriptiveResponseDictionary["Actors"] as? String
            let desMovieShortPlot = descriptiveResponseDictionary["Plot"] as? String
            let desMovieimbdID = descriptiveResponseDictionary["imdbID"] as? String
            let desMovieType = descriptiveResponseDictionary["Type"] as? String
            let desMovieimbdRating = descriptiveResponseDictionary["imdbRating"] as? String
            let desMoviePosterURL = descriptiveResponseDictionary["Poster"] as? String
            
            //unwrapping each of the of the json information
            guard let
                unwrappedDesMovieTitle = desMovieTitle,
                unwrappedDesMovieYear = desMovieYear,
                unwrappedDesMovieDirector = desMovieDirector,
                unwrappedDesMovieWriters = desMovieWriters,
                unwrappedDesMovieActors = desMovieActors,
                unwrappedDesMovieShortPlot = desMovieShortPlot,
                unwrappedDesMovieimbdID = desMovieimbdID,
                unwrappedDesMovieType = desMovieType,
                unwrappedDesMovieimbdRating = desMovieimbdRating,
                unwrappedDesMoviePosterURL = desMoviePosterURL
            
                else {print("AN ERROR OCCURRED HERE!"); return}
            
            //Creation of the Movie object with all the necessary properties initialized
            let descriptiveMovieObject = Movie.init(title: unwrappedDesMovieTitle, year: unwrappedDesMovieYear, director: unwrappedDesMovieDirector, writers: unwrappedDesMovieWriters, actors: unwrappedDesMovieActors, shortPlot: unwrappedDesMovieShortPlot, imbdID: unwrappedDesMovieimbdID, type: unwrappedDesMovieType, imbdRating: unwrappedDesMovieimbdRating, posterURL: unwrappedDesMoviePosterURL)
            
            self.descriptiveMovieArray.append(descriptiveMovieObject)
            
            //print out statements for checks 
            print("********************************************")
            print("Title: \(descriptiveMovieObject.title)")
            print("Year: \(descriptiveMovieObject.year)")
            print("Director: \(descriptiveMovieObject.director)")
            print("Writers: \(descriptiveMovieObject.writers)")
            print("Actors: \(descriptiveMovieObject.actors)")
            print("ShortPlot: \(descriptiveMovieObject.shortPlot)")
            print("imbdID: \(descriptiveMovieObject.imdbID)")
            print("imbdRating: \(descriptiveMovieObject.imdbRating)")
            print("PosterURL: \(descriptiveMovieObject.posterURL)")
            print("********************************************")
            
        }
        
        Completion(self.descriptiveMovieArray)
    }
    
    //Third API Call
    func getDescriptiveMovieFullPlotWith(imdbID: Movie, Completion: (NSArray) -> ())
    {
        OMDBAPIClient.getMovieFullPlotWith(String(imdbID)) { (fullPlotMovieDictionary) in
            
            let movieFullPlotTitle = fullPlotMovieDictionary["Title"] as? String
            let movieFullPlotimbdID = fullPlotMovieDictionary["imdbID"] as? String
            let movieFullPlot = fullPlotMovieDictionary["Plot"] as? String
            
            guard let
                unwrappedTitle = movieFullPlotTitle,
                unwrappedimbdID = movieFullPlotimbdID,
                unwrappedFullPlot = movieFullPlot
                
                else {print("AN ERROR OCCURRED HERE"); return}
            
                let descriptiveMovieWithFullPlot = Movie.init(title: unwrappedTitle, fullPlot: unwrappedFullPlot, imdbID: unwrappedimbdID)
                        
                self.descriptiveMovieFullPlotArray.append(descriptiveMovieWithFullPlot)
                        
                print("********************************************")
                print("Descriptive Title: \(descriptiveMovieWithFullPlot.title)")
                print("Descriptive imbdID: \(descriptiveMovieWithFullPlot.imdbID)")
                print("Descriptive Full Plot: \(descriptiveMovieWithFullPlot.fullPlot)")
                print("********************************************")
        }
        
        Completion(self.descriptiveMovieFullPlotArray)
        
        }
    
    //pagination Function
    func retrieveNextPageOfMovieInformation()
    {
        self.pageNum += 1
    }

    
}