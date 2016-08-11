//
//  SessionsDay1InterfaceController.swift
//  trySwift
//
//  Created by Natasha Murashev on 2/23/16.
//  Copyright © 2016 NatashaTheRobot. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation

class SessionsDay1InterfaceController: WKInterfaceController {

    @IBOutlet private var sessionsTable: WKInterfaceTable!
    
    private let sessions = Session.sessions(for: .date(year: 2016, month: 08, day: 31))
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let watchSession = WCSession.defaultSession()
        watchSession.delegate = self
        watchSession.activateSession()
        
        setTitle(isJapanese ? "3月2日（水）" : "try! Mar 2")
        loadTableData()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension SessionsDay1InterfaceController: WCSessionDelegate {
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String: AnyObject]) {
        guard let
            versionDictionary = applicationContext as? [String: Double],
            firstVersion = versionDictionary.first else { return }
        NSUserDefaults.standardUserDefaults().setDouble(firstVersion.1, forKey: firstVersion.0)
    }
}

private extension SessionsDay1InterfaceController {
    
    func loadTableData() {
        sessionsTable.setNumberOfRows(sessions.count, withRowType: String(SessionTableRowController))
        for (index, session) in sessions.enumerate() {
            let row = sessionsTable.rowControllerAtIndex(index) as? SessionTableRowController
            row?.configure(session)
        }
    }
}
