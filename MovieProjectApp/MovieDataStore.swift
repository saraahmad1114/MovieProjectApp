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
    //singleton for the MovieDataBase
    
    var movies = [Movie]()
    //array to store all the movie objects from the json
    
    let movieSearchTerms = ["love", "fantasy", "romance", "mystery", "thriller", "musical", "family", "horror", "sci-fi"]
    func getMoviesWithCompletion(Completion: () -> ())
    {
        let randomNumber = arc4random_uniform(UInt32(movieSearchTerms.count))
        
        OMDBAPIClient.getMovieResultsFromSearch(self.movieSearchTerms[Int(randomNumber)]) { (arrayOfMovies) in
            for singleMovie in arrayOfMovies
            {
                //all print statements are working and print as optionals - Predicted
                let movieTitle = singleMovie["Title"] as? String
                
                let movieYear = singleMovie["Year"] as? String
                
                let movieImbdID = singleMovie["imdbID"] as? String
                
                let movieType = singleMovie["Type"] as? String
                
                let moviePosterURL = singleMovie["Poster"] as? String
                
                if let unwrappedMovieTitle = movieTitle
                {
                    if let unwrappedMovieYear = movieYear
                    {
                        if let unwrappedMovieImbdID = movieImbdID
                        {
                            if let unwrappedMovieType = movieType
                            {
                                if let unwrappedMoviePosterURL = moviePosterURL
                                {
                                    let movie = Movie.init(title: unwrappedMovieTitle, year: unwrappedMovieYear, imdbID: unwrappedMovieImbdID, type: unwrappedMovieType, posterURL: unwrappedMoviePosterURL)
                                    
                                    print("****************************************")
                                    print("Movie Title: \(movie.title)")
                                    print("Movie Year: \(movie.year)")
                                    print("Movie ImdbID: \(movie.imdbID)")
                                    print("Movie Type: \(movie.type)")
                                    print("Movie PosterURL: \(movie.posterURL)")
                                    print("****************************************")
                                    
                                    self.movies.append(movie)
                                    print(self.movies.count)
                                }
                            }
                        }
                    }
                }
                
            }
            Completion()
        }
        
    }
    
    
    
}
