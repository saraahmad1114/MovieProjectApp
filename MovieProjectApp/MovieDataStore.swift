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
    
    var movies : [Movie] = []
    //array to store all the movie objects from the json
    
    let movieSearchTerms = ["love", "fantasy", "romance", "mystery", "thriller", "musical", "family", "horror", "sci-fi"]
    func getMoviesWithCompletion(Completion: () -> ())
    {
        let randomNumber = arc4random_uniform(UInt32(movieSearchTerms.count))
        //random number so to get random index from array
        
        OMDBAPIClient.getMovieResultsFromSearch(self.movieSearchTerms[Int(randomNumber)]) { (arrayOfMovies) in
            for singleMovie in arrayOfMovies
            {
                //all print statements are working and print as optionals - Predicted
                let movieTitle = singleMovie["Title"] as? String
                
//                print("******************printed optional movieTitle")
//                print(movieTitle)
//                print("*********************************************\n\n\n")
//                prints out the optionals, as anticipated!
                
                let movieYear = singleMovie["Year"] as? String
                
//                print("******************printed optional movieTitle")
//                print(movieYear)
//                print("*********************************************\n\n\n")
                //                prints out the optionals, as anticipated!

                
                let movieImbdID = singleMovie["imdbID"] as? String
                
//                print("******************printed optional movieTitle")
//                print(movieImbdID)
//                print("*********************************************\n\n\n")
                //                prints out the optionals, as anticipated!

                
                let movieType = singleMovie["Type"] as? String
                
//                print("******************printed optional movieTitle")
//                print(movieType)
//                print("*********************************************\n\n\n")
                //                prints out the optionals, as anticipated!

                
                let moviePosterURL = singleMovie["Poster"] as? String
                
//                print("******************printed optional movieTitle")
//                print(moviePosterURL)
//                print("*********************************************\n\n\n")
                //                prints out the optionals, as anticipated!

                
//                if let unwrappedMovieTitle = movieTitle
//                {
//                    if let unwrappedMovieYear = movieYear
//                    {
//                        if let unwrappedMovieImbdID = movieImbdID
//                        {
//                            if let unwrappedMovieType = movieType
//                            {
//                                if let unwrappedMoviePosterURL = moviePosterURL
//                                {
//                                    let singleMovieObject = Movie.init(title: unwrappedMovieTitle, year: unwrappedMovieYear, imdbID: unwrappedMovieImbdID, type: unwrappedMovieType, posterURL: unwrappedMoviePosterURL)
//                                    
//                                    print("****************************************")
//                                    print("Movie Title: \(singleMovieObject.title)")
//                                    print("Movie Year: \(singleMovieObject.year)")
//                                    print("Movie ImdbID: \(singleMovieObject.imdbID)")
//                                    print("Movie Type: \(singleMovieObject.type)")
//                                    print("Movie PosterURL: \(singleMovieObject.posterURL)")
//                                    print("****************************************")
//                                    
//                                    self.movies.append(singleMovieObject)
//                                    print(self.movies.count)
//                                }
                
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
                //this will print out the index of the movie object in the array
        
            }

            Completion()
            print(self.movies.count)
            //prints out a total of 10!!!!!!!
        }
        
        
    
}

}