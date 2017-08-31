//
//  Contact+CoreDataClass.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/30/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import CoreData

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
}