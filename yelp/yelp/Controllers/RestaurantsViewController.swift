//
//  ViewController.swift
//  yelp
//
//  Created by Michael Lewis on 2/14/15.
//  Copyright (c) 2015 Machel. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SettingsViewDelegate {

  @IBOutlet weak var restaurantTableView: UITableView!


  var searchBar: UISearchBar!

  let cellNibName = "RestaurantTableViewCell"
  let cellIdentifier = "com.machel.restaurant-cell"

  var client: YelpClient!
  var restaurants: NSArray?

  var filters: Dictionary<String, AnyObject>?


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    // Register our external RestaurantTableViewCell xib
    restaurantTableView.registerNib(
      UINib(
        nibName: cellNibName,
        bundle: NSBundle.mainBundle()
      ),
      forCellReuseIdentifier: cellIdentifier
    )

    // Set up utomatic row height
    restaurantTableView.rowHeight = UITableViewAutomaticDimension

    // Set up the search bar
    searchBar = UISearchBar()
    searchBar.delegate = self
    navigationItem.titleView = searchBar

    // Start with a default search term
    searchBar.text = "Thai"
    search("Thai")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    search(searchText)
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if restaurants != nil {
      return restaurants!.count
    } else {
      return 0
    }
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = restaurantTableView.dequeueReusableCellWithIdentifier(cellIdentifier) as RestaurantTableViewCell
    if restaurants != nil {
      cell.setRestaurantInfo(restaurants![indexPath.row] as NSDictionary)
    }
    return cell
  }


  // Set up a segue and the return delegate so that we can pass the filters
  // back down to this controller.
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "com.machel.settings-segue" {
      var navController = segue.destinationViewController as UINavigationController
      var controller = navController.childViewControllers[0] as SettingsViewController
      controller.delegate = self
    }
  }

  func returnFromModal(settingsController: SettingsViewController, filters: Dictionary<String, AnyObject>) {
    self.filters = filters
    print(self.filters)
    search()
    dismissViewControllerAnimated(true, completion: nil)
  }

  // Search, based upon what's in the search bar
  private func search() {
    search(self.searchBar.text)
  }

  // Search for a term and update the view, while avoiding race conditions.
  private func search(term: String) {
    if client == nil {
      client = YelpClient()
    }

    client.searchWithTerm(
      term,
      filters: filters,
      success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        // Make sure that we only display results for the current search term.
        // This will prevent showing stale results if somebody types quickly.
        if term == self.searchBar.text {
          self.restaurants = (response as NSDictionary)["businesses"] as? NSArray
          self.restaurantTableView.reloadData()
        }
      },
      failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
        NSLog(error.description)
      }
    )
  }
}

