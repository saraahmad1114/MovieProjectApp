//
//  iTunesAPIClient.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 10/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

//var itunesURL = "https://itunes.apple.com/search?term=\(query)+soundtrack&limit=30"


class iTunesAPIClient
{
    class func getMovieSoundTrackFromSearch(query: String, completion:(NSArray)-> ())
    {
        var resultsArrayOfDictionary : [NSDictionary] = []
        
        var itunesURL = "https://itunes.apple.com/search?term=\(query)+soundtrack&limit=30"
        
        itunesURL = itunesURL.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        let nsURL = NSURL(string: itunesURL)
        
        guard let unwrappednsURL = nsURL else {print("ERROR"); return}
        
        let request = NSMutableURLRequest(URL: unwrappednsURL)
        
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("Error occurred here"); return}
            
            if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSDictionary
            {
                guard let unwrappedResponseDictionary = responseDictionary else {print("ERROR"); return}
                
                let resultsArrayOfDictionaries = unwrappedResponseDictionary["results"] as? NSArray

                guard let unwrappedResultsArrayOfDictionaries = resultsArrayOfDictionaries else {
                    print("ERROR"); return}
                
                for singleDictionary in unwrappedResultsArrayOfDictionaries
                {
                    let castedSingleDictionary = singleDictionary as? NSDictionary
                    
                    guard let unwrappedSingleDictionary = castedSingleDictionary else{print("ERROR"); return}
                    
                    resultsArrayOfDictionary.append(unwrappedSingleDictionary)
                }
                
                 completion(resultsArrayOfDictionary)
            }
        
        }

        task.resume()
    
    }
    
    
}

        
        