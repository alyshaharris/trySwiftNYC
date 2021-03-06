//
//  SponsorTableViewCell.swift
//  trySwift
//
//  Created by Natasha Murashev on 2/11/16.
//  Copyright © 2016 NatashaTheRobot. All rights reserved.
//

import UIKit
import Haneke
import Toucan

class SponsorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sponsorImageView: UIImageView!
    @IBOutlet weak var sponsorNameLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        websiteLabel.textColor = .twitterBlue()
    }
    
    func configure(withSponsor sponsor: Sponsor) {
        if let
            imageURLString = sponsor.logoURL,
            imageURL = NSURL(string: imageURLString) {
            sponsorImageView.hnk_setImageFromURL(imageURL, placeholder: sponsor.logo)
        } else {
            sponsorImageView.image = sponsor.logo
        }
        sponsorNameLabel.text = sponsor.name
        websiteLabel.text = sponsor.website
    }
}
