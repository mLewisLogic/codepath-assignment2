//
//  ViewController.swift
//  yelp
//
//  Created by Michael Lewis on 2/14/15.
//  Copyright (c) 2015 Machel. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var searchBar: UISearchBar!
    var currentSearchTerm: String!

    let cellNibName = "RestaurantTableViewCell"
    let cellIdentifier = "com.machel.restaurant-cell"

    var client: YelpClient!
    var restaurants: NSArray?


    @IBOutlet weak var restaurantTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Register our external RestaurantTableViewCell xib
        self.restaurantTableView.registerNib(
            UINib(
                nibName: cellNibName,
                bundle: NSBundle.mainBundle()
            ),
            forCellReuseIdentifier: cellIdentifier
        )

        // Set up utomatic row height
        self.restaurantTableView.rowHeight = UITableViewAutomaticDimension

        // Set up the search bar
        self.searchBar = UISearchBar()
        self.searchBar.delegate = self
        self.navigationItem.titleView = self.searchBar

        // Start with a default search term
        self.searchBar.text = "Thai"
        self.search("Thai")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        NSLog(searchText)
        self.search(searchText)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.restaurants != nil {
            return self.restaurants!.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.restaurantTableView.dequeueReusableCellWithIdentifier(cellIdentifier) as RestaurantTableViewCell
        if self.restaurants != nil {
            cell.setRestaurantInfo(self.restaurants![indexPath.row] as NSDictionary)
        }
        return cell
    }


    private func search(term: String) {
        if self.client == nil {
            self.client = YelpClient()
        }

        self.currentSearchTerm = term

        self.client.searchWithTerm(
            term,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                // Make sure that we only display results for the current search term.
                // This will prevent showing stale results if somebody types quickly.
                if term == self.currentSearchTerm {
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

