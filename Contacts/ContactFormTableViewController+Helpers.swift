//
//  ContactFormViewController+Helpers.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/31/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import UIKit

extension ContactFormTableViewController {
    // MARK: - Value validator
    
    func isNameValid() -> Bool {
        guard firstNameTextField.text != "" && lastNameTextField.text != "" else {
            return false
        }
        return true
    }
    
    func isContactValid() -> Bool {
        guard isNameValid() == true else {
            let controller = UIAlertController(title: "Error", message: "Can't create a contact without a first name and last name", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
            controller.addAction(dismissAction)
            present(controller, animated: true, completion: nil)
            return false
        }
        
        guard emailTextField.text?.isValidEmail() == true else {
            let controller = UIAlertController(title: "Error", message: "Email address is in a wrong format", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
            controller.addAction(dismissAction)
            present(controller, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    // MARK - ContactController
    func getContactDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        if let firstName = firstNameTextField.text {
            dictionary["first_name"] = firstName
        }
        
        if let lastName = lastNameTextField.text {
            dictionary["last_name"] = lastName
        }
        
        if let phoneNumber = mobileTextField.text {
            dictionary["phone_number"] = phoneNumber
        }
        
        if let email = emailTextField.text {
            dictionary["email"] = email
        }
        
        if let image = profilePictureImageView.image, image != #imageLiteral(resourceName: "user") {
            if let imageData = UIImagePNGRepresentation(image) as NSData? {
                dictionary["profile_pic_image"] = imageData
            }
        }
        
        if let contact = contact {
            if contact.createdAt == nil {
                dictionary["created_at"] = Date().formatToString()
            } else {
                dictionary["updated_at"] = Date().formatToString()
            }
            
            if contact.id == 0 {
                let uuid = UUID().uuidString
                dictionary["id"] = uuid
            }
        }
        
        return dictionary
    }
    
    func createContact() {
        let dictionary = getContactDictionary()
        let _ = Contact(dictionary: dictionary, context: coreDataStack.managedObjectContext)
    }
    
    func modifyContact(contact: Contact) {
        
        if let firstName = firstNameTextField.text {
            contact.firstName = firstName
        }
        
        if let lastName = lastNameTextField.text {
            contact.lastName = lastName
        }
        
        if let image = profilePictureImageView.image, image != #imageLiteral(resourceName: "user") {
            let imageData = UIImagePNGRepresentation(image)! as NSData
            if let contactImageData = contact.profilePictureImage {
                if imageData != contactImageData {
                    contact.profilePictureImage = imageData
                }
            } else {
                contact.profilePictureImage = imageData
            }
        }
        
        if let phoneNumber = mobileTextField.text {
            contact.phoneNumber = phoneNumber
        }
        
        if let email = emailTextField.text {
            contact.email = email
        }
        
        if contact.createdAt == nil {
            contact.createdAt = Date() as NSDate
        } else {
            contact.updatedAt = Date() as NSDate
        }
        
        if contact.id == 0 {
            let uuid = arc4random_uniform(9999999)
            contact.id = Int32(uuid)
        }
    }
}
