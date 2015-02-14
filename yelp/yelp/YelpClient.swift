//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {

    let baseUrlString = "http://api.yelp.com/v2/"

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        if let settings = loadSettings() {
            if let yelpSettings = settings["Yelp"] as? Dictionary<String, String> {
                var baseUrl = NSURL(string: baseUrlString)
                super.init(
                    baseURL: baseUrl,
                    consumerKey: yelpSettings["consumer_key"],
                    consumerSecret: yelpSettings["consumer_secret"]
                )

                var token = BDBOAuthToken(
                    token: yelpSettings["token"],
                    secret: yelpSettings["token_secret"],
                    expiration: nil
                )
                self.requestSerializer.saveAccessToken(token)

            } else {
                NSLog("Missing Yelp node in private.plist file. Expect Yelp access to fail.")
            }
        } else {
            NSLog("Missing valid private.plist file. Expect Yelp access to fail.")
        }
    }

    func searchWithTerm(term: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters = ["term": term, "location": "San Francisco"]
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }



    /* Private below */

    // Pull our private credendtial settings as a Dictionary.
    private func loadSettings() -> Dictionary<String, AnyObject>? {
        if let path = NSBundle.mainBundle().pathForResource("private", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                // If we got this far, we have a valid dict
                return dict
            }
        }

        return nil
    }
}

