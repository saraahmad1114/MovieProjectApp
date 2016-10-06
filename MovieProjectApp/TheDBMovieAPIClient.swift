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
    class func getMovieTrailerFrom(query: String, completion: (String)->())
    {
        var videoKey: String = ""
        
        let url = "https://api.themoviedb.org/3/movie/tt0414993/videos?api_key=\(Secrets.theMovieDBAPIKey)"
        
        let nsURL = NSURL(string: url)
        
        guard let unwrappednsURL = nsURL else {print("ERROR"); return}
        
        let request = NSMutableURLRequest(URL: unwrappednsURL)
        
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
            if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSDictionary
            {
                guard let unwrappedResponseDictionary = responseDictionary else {print("ERROR"); return}
                
                let resultsArray = unwrappedResponseDictionary["results"] as? NSArray
                
                guard let unwrappedResultsArray = resultsArray else {print("ERROR"); return}
                
                let neededDictionary = unwrappedResultsArray[0] as? NSDictionary
                
                guard let unwrappedNeededDictionary = neededDictionary else {print("ERROR"); return}
                
                let neededKey = unwrappedNeededDictionary["key"] as? String
                
                guard let unwrappedNeededKey = neededKey else {print("ERROR"); return}
                
                videoKey = unwrappedNeededKey
            
            }
            completion(videoKey)
        }
        
        task.resume()

    }

}
