//
//  SettingsViewController.swift
//  yelp
//
//  Created by Michael Lewis on 2/15/15.
//  Copyright (c) 2015 Machel. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: class {
  func returnFromModal(settingsController: SettingsViewController, filters: Dictionary<String, AnyObject>)
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PriceSelectorCellDelegate, SelectorCellDelegate {

  @IBOutlet weak var settingsTableView: UITableView!

  weak var delegate: SettingsViewDelegate?

  let priceSelectorCellNibName = "PriceSelectorTableViewCell"
  let priceSelectorCellIdentifier = "com.machel.price-selector-cell"

  let selectorCellNibName = "SelectorTableViewCell"
  let selectorCellIdentifier = "com.machel.selector-cell"

  var filters = [
    "price": "",
    "open_now": false,
    "hot_and_new": false,
    "offering_a_deal": false,
    "delivery": false,
    "distance": "auto",
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.

    // Register our external xibs
    settingsTableView.registerNib(
      UINib(
        nibName: priceSelectorCellNibName,
        bundle: NSBundle.mainBundle()
      ),
      forCellReuseIdentifier: priceSelectorCellIdentifier
    )
    settingsTableView.registerNib(
      UINib(
        nibName: selectorCellNibName,
        bundle: NSBundle.mainBundle()
      ),
      forCellReuseIdentifier: selectorCellIdentifier
    )
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 3
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Price"
    case 1:
      return "Most Popular"
    case 2:
      return "Distance"
    default:
      return nil
    }
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
      case 0:
        return 1
      case 1:
        return 4
      case 2:
        return 1
      default:
        return 0
    }
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      var cell = settingsTableView.dequeueReusableCellWithIdentifier(priceSelectorCellIdentifier) as PriceSelectorTableViewCell
      cell.setPrice(filters["price"] as String)
      cell.delegate = self
      return cell
    case 1:
      var cell = settingsTableView.dequeueReusableCellWithIdentifier(selectorCellIdentifier) as SelectorTableViewCell
      switch indexPath.row {
      case 0:
        cell.titleLabel.text = "Open Now"
        cell.selectionSwitch.on = filters["open_now"] as Bool
        //cell.extraLabel.hidden = false
        //cell.extraLabel.text =
      case 1:
        cell.titleLabel.text = "Hot & New"
        cell.selectionSwitch.on = filters["hot_and_new"] as Bool
      case 2:
        cell.titleLabel.text = "Offering a Deal"
        cell.selectionSwitch.on = filters["offering_a_deal"] as Bool
      case 3:
        cell.titleLabel.text = "Delivery"
        cell.selectionSwitch.on = filters["delivery"] as Bool
      default:
        cell.titleLabel.text = "Error"
      }
      cell.delegate = self
      return cell
    default:
      return UITableViewCell()
    }
  }

  func priceSelectorView(selectorCell: PriceSelectorTableViewCell, priceChangedTo value: String) {
    filters["price"] = value
  }

  func selectorView(selectorCell: SelectorTableViewCell, valueChangedTo value: Bool) {
    if let indexPath = settingsTableView.indexPathForCell(selectorCell) {
      switch indexPath.section {
      case 1:
        switch indexPath.row {
        case 0:
          filters["open_now"] = value
        case 1:
          filters["hot_and_new"] = value
        case 2:
          filters["offering_a_deal"] = value
        case 3:
          filters["delivery"] = value
        default:
          break
        }
      default:
        break
      }
    }
  }

  @IBAction func searchButtonActivated(sender: UIBarButtonItem) {
    delegate?.returnFromModal(self, filters: self.filters)
  }


  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */

}
