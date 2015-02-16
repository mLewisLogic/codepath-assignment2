//
//  PriceSelectorTableViewCell.swift
//  yelp
//
//  Created by Michael Lewis on 2/15/15.
//  Copyright (c) 2015 Machel. All rights reserved.
//

import UIKit

protocol PriceSelectorCellDelegate: class {
  func priceSelectorView(selectorCell: PriceSelectorTableViewCell, priceChangedTo value: String)
}

class PriceSelectorTableViewCell: UITableViewCell {

  @IBOutlet weak var priceControl: UISegmentedControl!

  weak var delegate: PriceSelectorCellDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func setPrice(price: String) {
    switch price {
    case "$":
      priceControl.selectedSegmentIndex = 0
    case "$$":
      priceControl.selectedSegmentIndex = 1
    case "$$$":
      priceControl.selectedSegmentIndex = 2
    case "$$$$":
      priceControl.selectedSegmentIndex = 3
    default:
      priceControl.selectedSegmentIndex = UISegmentedControlNoSegment
    }
  }

  @IBAction func priceChanged(sender: UISegmentedControl) {
    if let value = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex) {
      delegate?.priceSelectorView(self, priceChangedTo: value)
    }
  }
}
