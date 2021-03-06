//
//  AboutTableViewController.swift
//  trySwift
//
//  Created by Natasha Murashev on 2/12/16.
//  Copyright © 2016 NatashaTheRobot. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {

    private let trySwift = Conference.trySwift
    
    private enum AboutInfo: Int {
        case Header, Detail, Twitter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = isJapanese ? "try! Conferenceについて" : "About"
        
        tableView.registerNib(UINib(nibName: String(OrganizerTableViewCell), bundle: nil), forCellReuseIdentifier: String(OrganizerTableViewCell))
        tableView.registerNib(UINib(nibName: String(TextTableViewCell), bundle: nil), forCellReuseIdentifier: String(TextTableViewCell))
        tableView.registerNib(UINib(nibName: String(TwitterFollowTableViewCell), bundle: nil), forCellReuseIdentifier: String(TwitterFollowTableViewCell))
        
        tableView.estimatedRowHeight = 83
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .None
    }
}

// MARK: - Table view data source
extension AboutTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch AboutInfo(rawValue: indexPath.row)! {
        case .Header:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(OrganizerTableViewCell), forIndexPath: indexPath) as! OrganizerTableViewCell
            cell.configure(withConference: trySwift)
            cell.selectionStyle = .None
            cell.accessoryType = .None
            return cell
        case .Detail:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(TextTableViewCell), forIndexPath: indexPath) as! TextTableViewCell
            cell.configure(withText: trySwift.description)
            return cell
        case .Twitter:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(TwitterFollowTableViewCell), forIndexPath: indexPath) as! TwitterFollowTableViewCell
            cell.configure(withUsername: trySwift.twitter, delegate: self)
            return cell
        }
    }
    
}

extension AboutTableViewController: TwitterFollowDelegate {
    
    func followUser(username: String) {
        var applicationOpened = false
        let application = UIApplication.sharedApplication()
        for twitterURL in Twitter.urls(forUsername: username) {
            if let url = NSURL(string: twitterURL) where application.canOpenURL(url) && !applicationOpened {
                application.openURL(url)
                applicationOpened = true
                break
            }
        }
        
        if !applicationOpened {
            if let twitterURL = NSURL(string: "http://twitter.com/\(username)") {
                openSafariViewController(withURL: twitterURL)
            }
        }
    }
}

