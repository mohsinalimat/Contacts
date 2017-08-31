//
//  Contact+CoreDataClass.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/30/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Contact)
public class Contact: NSManagedObject {
    convenience init(dictionary: [String: Any], context: NSManagedObjectContext) {
        if let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context) {
            self.init(entity: entity, insertInto: context)
            if let id = dictionary["id"] as? Int32 {
                self.id = id
            } else {
                self.id = 0
            }
            
            if let firstName = dictionary["first_name"] as? String {
                self.firstName = firstName
            } else {
                self.firstName = nil
            }
            
            if let lastName = dictionary["last_name"] as? String {
                self.lastName = lastName
            } else {
                self.lastName = nil
            }
            
            if let profilePictureURL = dictionary["profile_pic"] as? String {
                self.profilePictureURL = profilePictureURL
            } else {
                self.profilePictureURL = nil
            }
            
            if let phoneNumber = dictionary["phone_number"] as? String {
                self.phoneNumber = phoneNumber
            } else {
                self.phoneNumber = nil
            }
            
            if let email = dictionary["email"] as? String {
                self.email = email
            } else {
                self.email = nil
            }
            
            if let profilePictureImageData = dictionary["profile_pic_image"] as? NSData {
                self.profilePictureImage = profilePictureImageData
            } else {
                self.profilePictureImage = nil
            }
            
            if let favorite = dictionary["favorite"] as? Bool {
                self.favorite = favorite
            } else {
                self.favorite = false
            }
            
            if let detailURL = dictionary["url"] as? String {
                self.detailURL = detailURL
            } else {
                self.detailURL = "http://gojek-contacts-app.herokuapp.com/contacts/\(self.id).json"
            }
            
            // FIXME: - Assign detail properties here
            
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    
    var initialCharacter: String {
        if let firstName = firstName {
            let initial = (firstName.uppercased() as NSString).substring(to: 1)
            return initial
        } else if let lastName = lastName {
            let initial = (lastName.uppercased() as NSString).substring(to: 1)
            return initial
        } else {
            return "#"
        }
    }
}
