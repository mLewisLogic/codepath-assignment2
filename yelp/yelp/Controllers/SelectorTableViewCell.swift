//
//  SelectorTableViewCell.swift
//  yelp
//
//  Created by Michael Lewis on 2/15/15.
//  Copyright (c) 2015 Machel. All rights reserved.
//

import UIKit

protocol SelectorCellDelegate: class {
  func selectorView(selectorCell: SelectorTableViewCell, valueChangedTo value: Bool)
}

class SelectorTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var extraLabel: UILabel!
  @IBOutlet weak var selectionSwitch: UISwitch!

  weak var delegate: SelectorCellDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  @IBAction func switchChanged(sender: UISwitch) {
    delegate?.selectorView(self, valueChangedTo: sender.on)
  }
}
