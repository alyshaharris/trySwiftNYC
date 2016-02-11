//
//  SpeakersViewController.swift
//  trySwift
//
//  Created by Natasha Murashev on 2/11/16.
//  Copyright © 2016 NatashaTheRobot. All rights reserved.
//

import UIKit

class SpeakersViewController: UITableViewController {

    private let speakers = Speaker.speakers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = isJapanese ? "講演者" : "Speakers"
        
        tableView.registerNib(UINib(nibName: String(SpeakerTableViewCell), bundle: nil), forCellReuseIdentifier: String(SpeakerTableViewCell))
        tableView.estimatedRowHeight = 83
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SpeakerTableViewCell), forIndexPath: indexPath) as! SpeakerTableViewCell
        
        cell.configure(withSpeaker: speakers[indexPath.row])
        
        return cell
    }
}