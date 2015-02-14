//
//  ViewController.swift
//  yelp
//
//  Created by Michael Lewis on 2/14/15.
//  Copyright (c) 2015 Machel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellNibName = "RestaurantTableViewCell.xib"
    let cellIdentifier = "com.machel.restaurant-cell"


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

        self.restaurantTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.restaurantTableView.dequeueReusableCellWithIdentifier(cellIdentifier) as RestaurantTableViewCell

        return cell
    }

}

