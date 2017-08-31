//
//  EditContactTableViewController.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import UIKit
import CoreData

class EditContactTableViewController: UITableViewController {
    
    var contact: Contact? = nil
    
    var coreDataStack: CoreDataStack!
    
    // MARK: - TextField outlets
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.coreDataStack = appDelegate.coreDataStack
        
        if let contact = contact {
            print(contact)
            configureContactTextFields(with: contact)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functions
    func configureContactTextFields(with contact: Contact) {
        if let firstName = contact.firstName {
            firstNameTextField.text = firstName
        }
        
        if let lastName = contact.lastName {
            lastNameTextField.text = lastName
        }
        
        if let phoneNumber = contact.phoneNumber{
            mobileTextField.text = phoneNumber
        }
        
        if let email = contact.email{
            emailTextField.text = email
        }
    }
    
    func getDictionary() -> [String: Any] {
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
    
    func modifyContact(contact: Contact) {
        if let firstName = firstNameTextField.text {
            contact.firstName = firstName
        }
        
        if let lastName = lastNameTextField.text {
            contact.lastName = lastName
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "done's segue" {
            if let contact = contact {
                modifyContact(contact: contact)
                print("a contact has been modified: \(contact)")
            } else {
                let dictionary = getDictionary()
                let contact = Contact(dictionary: dictionary, context: coreDataStack.managedObjectContext)
                print("Initialize a new contact: \(contact)")
            }
            coreDataStack.saveContext()
        }
    }

}

extension EditContactTableViewController: UITextFieldDelegate {
    
}
