////
//  MovieDataStore.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/7/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class MovieDataStore
{
//    static let sharedInstance = MovieDataStore()
//    private init() {}
//    //creating a singleton for the MovieDataStore 
// 
//    var movies = [Movie]()
//    //array to store all the movie objects from the json
//    
//    let movieSearchTerms = ["love", "fantasy", "romance", "mystery", "thriller", "musical", "family", "horror", "sci-fi"]
//    
//    func getMoviesWithCompletion(completion: () -> ()) {
//    
//        OMDBAPIClient.getMovieResultsFromSearch(self.movieSearchTerms[Int(arc4random_uniform(UInt32(movieSearchTerms.count)))]) { (arrayOfMovies) in
//            for singleMovie in arrayOfMovies
//            {
//                
//                let neededTitle = singleMovie["title"] as? String
//                let neededYear = singleMovie["year"] as? String
//                let neededImbdID = singleMovie["imdbID"] as? String
//                let neededType = singleMovie["type"] as? String
//                let neededPosterURL = singleMovie["posterURL"] as? String
//                
//                guard let
//                    
//                    unwrappedTitle = neededTitle,
//                    unwrappedYear = neededType,
//                    unwrappedImbdID = neededImbdID,
//                    unwrappedType = neededType,
//                    unwrappedPosterURL = neededPosterURL
//                
//                    else { print("AN ERROR OCCURRED HERE"); return }
//                
//                var movie = Movie.init(title: unwrappedTitle, year: singleMovie["year"], imdbID: singleMovie["imbdID"], type: singleMovie["type"], posterURL: singleMovie["posterURL"])
//        
//                movies.append(movie)
//            }
//            completion()
//        }
//    
//}
//
//
}