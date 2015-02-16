//
//  RestaurantTableViewCell.swift
//  yelp
//
//  Created by Michael Lewis on 2/14/15.
//  Copyright (c) 2015 Machel. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var starsImageView: UIImageView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var numReviewsLabel: UILabel!
  @IBOutlet weak var categoriesLabel: UILabel!

  var restaurantInfo: NSDictionary?


  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    photoImageView.contentMode = .ScaleAspectFit
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func setRestaurantInfo(info: NSDictionary) {
    restaurantInfo = info
    reloadData()
  }

  private func reloadData() {
    if let info = restaurantInfo {
      if let imageUrl = info["image_url"] as? String {
        photoImageView.setImageWithURL(NSURL(string: imageUrl))
      }

      if let name = info["name"] as? String {
        nameLabel.text = name
      }

      if let distance = info["distance"] as? Double {
        let distance_in_km = distance / 1000.0
        let distance_in_mi = distance_in_km * 0.621371

        // Start wide, and narrow the formatting based upon distance
        var format_string = "%.0f mi"
        if distance_in_mi < 10.0 {
          format_string = "%.1f mi"
        }
        if distance_in_mi < 0.2 {
          format_string = "%.2f mi"
        }
        distanceLabel.text = String(format: format_string, distance_in_mi)
      }

      if let starsUrl = info["rating_img_url"] as? String {
        starsImageView.setImageWithURL(NSURL(string: starsUrl))
      }

      if let location = info["location"] as? NSDictionary {
        if let address = location["display_address"] as? NSArray {
          addressLabel.text = "\(address[0]) \(address[1])"
        }
      }

      if let reviewCount = info["review_count"] as? Int {
        numReviewsLabel.text = "\(reviewCount) reviews"
      }

      if let categories = info["categories"] as? Array<NSArray> {
        // Each category is actually a tuple. Grab the first of each.
        categoriesLabel.text = ", ".join(
          categories.map { (var cat) -> String in
            return cat[0] as String
          }
          ) as String
      }
    }
  }
}
