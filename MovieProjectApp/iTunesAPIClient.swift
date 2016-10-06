//
//  iTunesAPIClient.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 10/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class iTunesAPIClient
{
    func getSoundTrackFromSearch(query: String, completion:(NSArray)-> ())
    {
        var arrayOfDictionary : [[String : String]] = []
        
        var itunesURL = "https://itunes.apple.com/search?term=\(query)+soundtrack&limit=30"
        
        itunesURL = itunesURL.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        let nsURL = NSURL(string: itunesURL)
        
        guard let unwrappedNSURL = nsURL else {print("AN ERROR OCCURRED HERE"); return}
        
        let request = NSMutableURLRequest(URL: unwrappedNSURL)
        
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error)
            in
        
            guard let unwrappedData = data else {print("Error occurred here"); return}

            if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSDictionary
            {
                guard let unwrappedResponseDictionary = responseDictionary else {print("This did not work!"); return}
                
                let resultsArray = unwrappedResponseDictionary["results"] as? NSArray
                
                guard let unwrappedResultsArray = resultsArray else {print("AN ERROR OCCURRED HERE"); return}
                
                for singleDictionary in unwrappedResultsArray
                {
                    let unwrappedSingleDictionary = singleDictionary as? [String: String]
                    
                    guard let unwrappedAgainSingleDictionary = unwrappedSingleDictionary else {print("This works!"); return}
                    
                    arrayOfDictionary.append(unwrappedAgainSingleDictionary)
                
                }
                 completion(arrayOfDictionary)
            }
    
        }
         task.resume()
    }
}
