//
//  Speaker.swift
//  trySwift
//
//  Created by Natasha Murashev on 2/10/16.
//  Copyright © 2016 NatashaTheRobot. All rights reserved.
//

import UIKit
import Freddy

#if os(iOS)
import Toucan
#endif

struct Speaker {
    let id: Int
    let name: String
    let twitter: String
    let image: UIImage?
    let imageURL: String?
    let bio: String
    let presentation: Presentation
}

extension Speaker: JSONDecodable {
    
    init(json: JSON) throws {
        self.id = try json.int("id")
        self.name = try json.string("name")
        self.twitter = try json.string("twitter", alongPath: [.NullBecomesNil]) ?? ""
        if let
            imageString = try json.string("image", alongPath: [.NullBecomesNil]),
            image = UIImage(named: imageString) {
            #if os(iOS)
                self.image = Toucan(image: image).maskWithEllipse().image
            #else
                self.image = image
            #endif
        } else {
            self.image = nil
        }
        self.imageURL = try json.string("imageURL", alongPath: [.NullBecomesNil])
        self.bio = try json.string("bio")
        self.presentation = try Presentation(json: JSON(json.dictionary("presentation")))
    }
}

extension Speaker {
    
    static let speakers: [Speaker] = {
        do {
            return try JSONManager.dataJSON().array("speakers").filter { try !$0.bool("organizer") }.map(Speaker.init)
        } catch {
            print(error)
            return []
        }
    }()
}
