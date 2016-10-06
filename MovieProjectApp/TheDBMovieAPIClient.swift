//
//  TheDBMovieAPIClient.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 10/6/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class DBMovieAPIClient
{
    
    class func getMovieTrailerFrom(query: String, completion: (String)->())
    {
        var videoKey: String = ""
        
        let url = "https://api.themoviedb.org/3/movie/tt0414993/videos?api_key=\(Secrets.theMovieDBAPIKey)"
        
        let nsURL = NSURL(string: url)
        
        guard let unwrappednsURL = nsURL else {print("ERROR"); return}
        
        let request = NSMutableURLRequest(URL: unwrappednsURL)
        
        request.HTTPMethod = "GET"
        
        
        
        
    }

}
