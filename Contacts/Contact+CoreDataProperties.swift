//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/30/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var createdAt: NSDate?
    @NSManaged public var detailURL: String?
    @NSManaged public var email: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var firstName: String?
    @NSManaged public var id: Int32
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var profilePictureImage: NSData?
    @NSManaged public var profilePictureURL: String?
    @NSManaged public var updatedAt: NSDate?

}
