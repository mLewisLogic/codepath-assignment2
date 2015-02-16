//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

// This provides a nice wrapper for the request manager
class YelpClient {

  var manager: YelpClientRequestOperationManager!

  var lat = "37.777014"
  var lon = "-122.424211"

  init() {
    if let settings = loadSettings() {
      if let yelpSettings = settings["Yelp"] as? Dictionary<String, String> {
        manager = YelpClientRequestOperationManager(
          consumerKey:    yelpSettings["consumer_key"],
          consumerSecret: yelpSettings["consumer_secret"],
          accessToken:    yelpSettings["token"],
          accessSecret:   yelpSettings["token_secret"]
        )
      } else {
        NSLog("Missing Yelp node in private.plist file. Expect Yelp access to fail.")
      }
    } else {
      NSLog("Missing valid private.plist file. Expect Yelp access to fail.")
    }
  }

  func searchWithTerm(
    term: String,
    filters: Dictionary<String, AnyObject>?,
    success: (AFHTTPRequestOperation!, AnyObject!) -> Void,
    failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    var parameters = [
      "term": term,
      "ll": "\(lat),\(lon)",
    ]
    if let filters = filters {
      if let price = filters["price"] as? String {
        // Price isn't supported
      }
      if let open_now = filters["open_now"] as? Bool {
        
      }
    }
    return manager.GET("search", parameters: parameters, success: success, failure: failure)
  }


  /* Private below */

  // Pull our private credential settings as a Dictionary.
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

// The actual request handler
class YelpClientRequestOperationManager: BDBOAuth1RequestOperationManager {

  let baseUrlString = "http://api.yelp.com/v2/"

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
    var baseUrl = NSURL(string: baseUrlString)
    super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);

    var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
    requestSerializer.saveAccessToken(token)
  }
}
