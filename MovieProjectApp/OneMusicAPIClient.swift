//
//  OneMusicAPIClient.swift
//  MovieProjectApp
//
//  Created by Flatiron School on 9/29/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class OneMusicAPIClient
{
    class func getArtistAndSongsInformationWith(title: String, artist: String, countNum: Int, completion:(NSDictionary)-> ())
    {
        var musicDictionary : [String : String] = [:]
        //This dictionary will hold all the information
        
        var countNum = 1
        //for pagination purposes
        
        var musicURL = "http://api.onemusicapi.com/20150623/release?title=\(title)&artist=\(artist)&user_key=\(Secrets.musicAPIKey)&inc=images&maxResultCount=\(countNum)"
        //music URL
        
        if musicURL.containsString(" ") {
            
            musicURL = musicURL.stringByReplacingOccurrencesOfString(" ", withString: "+")
        }
        //when searching for the artist or the album if it contains any spaces then add the plus so that the URL works
        
        let nsurl = NSURL(string: musicURL)
        //conversion of the url into NSURL
        
        guard let unwrappedNSURL = nsurl else {print("ERROR OCCURRED HERE!"); return}
        //unwrapping of the NSURL
        
        let session = NSURLSession.sharedSession()
        //Creation of the session
        
        let request = NSMutableURLRequest(URL: unwrappedNSURL)
        //creation of the request 
        
        request.HTTPMethod = "GET"
        //request has an HTTPMethod of type "GET" to obtain information
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
        guard let unwrappedData = data else {print("ERROR OCCURRED HERE"); return}
        
            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSArray
            {
                guard let unwrappedResponseArray = responseArray else {print("ERROR OCCURRED HERE"); return}
                
                let dictionaryInArray = unwrappedResponseArray[0] as? [String : String]
                
                guard let unwrappedDictionaryInArray = dictionaryInArray else {print("AN ERROR OCCURRED HERE!"); return}

                musicDictionary = unwrappedDictionaryInArray
            }
        completion(musicDictionary)
        }
    task.resume()
    }

}
