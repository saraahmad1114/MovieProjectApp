//
//  TheDBMovieAPIClient.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 10/6/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class TheDBMovieAPIClient
{
    class func getMovieTrailerFrom(query: String, completion: (NSDictionary)->())
    {
        var videoInfoDictionary : [String : String] = [:]
        
        let movieTrailerURL = "https://api.themoviedb.org/3/movie/\(query)/videos?api_key=\(Secrets.theMovieDBAPIKey)"
        
        let nsurl = NSURL(string: movieTrailerURL)
        
        guard let unwrappednsURL = nsurl else {print("ERROR OCCURRED HERE"); return}
        
        let request = NSMutableURLRequest(URL: unwrappednsURL)
        
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
            if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSDictionary
            {
                guard let unwrappedResponseDictionary = responseDictionary else {print("This did not work!"); return}
                
                let resultsArray = unwrappedResponseDictionary["results"] as? NSArray
                
                guard let unwrappedResultsArray = resultsArray else {print("ERROR OCCURRED HERE"); return}
                
                let firstDictionary = unwrappedResultsArray[0] as? [String : String]
                
                guard let unwrappedFirstDictionary = firstDictionary else {print("ERROR OCCURRED HERE"); return}
                
                videoInfoDictionary = unwrappedFirstDictionary
                
            }
            
            completion(videoInfoDictionary)
        }
        task.resume()
    }
}
