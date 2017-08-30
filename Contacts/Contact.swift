//
//  Contact.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import UIKit

struct Contact {
    var id: Int
    var firstName: String
    var lastName: String
    var profilePictureURL: URL?
    var profilePictureImage: UIImage?
    var favorite: Bool
    var datailURL: URL
    var detail: Detail?
    
    init(_ contactDictionary: [String: Any]) {
        self.id = (contactDictionary["id"] as? Int) ?? 0
        self.firstName = (contactDictionary["first_name"] as? String ?? "")
        self.lastName = (contactDictionary["last_name"] as? String ?? "")
        self.profilePictureURL = URL(string: (contactDictionary["profile_pic"] as? String)!) ?? nil
        // TODO: profilePictureImageDownload
        self.profilePictureImage = nil
        self.favorite = (contactDictionary["favorite"] as? Bool) ?? false
        self.datailURL = URL(string: (contactDictionary["url"] as! String))!
        self.detail = nil
    }
}

struct Detail {
    var email: String
    var phoneNumber: String
    var createdAt: Date
    var updatedAt: Date
    
    init(detailDictionary: [String: Any]) {
        // TODO: initialize detail
        self.email = detailDictionary["email"] as! String
        self.phoneNumber = detailDictionary["phone_number"] as! String
        let created_at = detailDictionary["created_at"] as! String
        self.createdAt = created_at.formatToDate()
        let updated_at = detailDictionary["updated_at"] as! String
        self.updatedAt = updated_at.formatToDate()
    }
}

