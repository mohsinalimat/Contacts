//
//  ContactFormTableViewController.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import UIKit
import CoreData

class ContactFormTableViewController: UITableViewController {
    
    var contact: Contact? = nil
    
    lazy var coreDataStack: CoreDataStack = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataStack
    }()
    
    @IBAction func cancelContact(_ sender: Any) {
        unwindSegue()
    }
    
    @IBAction func saveContact(_ sender: Any) {
        
        guard isValidChange() == true else {
            let controller = UIAlertController(title: "Error", message: "Can't create a contact without a first name and last name", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Okay", style: .destructive, handler: nil)
            controller.addAction(dismissAction)
            present(controller, animated: true, completion: nil)
            return
        }
        
        if let contact = contact {
            modifyContact(contact: contact)
        } else {
            let dictionary = getDictionary()
            let _ = Contact(dictionary: dictionary, context: coreDataStack.managedObjectContext)
        }
        coreDataStack.saveContext()
        unwindSegue()
    }
    
    
    @IBAction func deleteContact(_ sender: Any) {
        guard let contact = contact else { return }
        let controller = UIAlertController(title: "Are you sure to delete this contact?", message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action: UIAlertAction) in
            self.coreDataStack.managedObjectContext.delete(contact)
            self.unwindSegue()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(deleteAction)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
        
        
    }
    
    // MARK: - TextField outlets
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var deleteContactButton: UIButton!
    @IBOutlet weak var deleteCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTextField.addTarget(self, action: #selector(updatePhoneNumberFormattedTextField(sender:)), for: UIControlEvents.editingChanged)
        
        if let contact = contact {
            configureUI(with: contact)
        } else {
            deleteCell.isHidden = true
        }
        
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presentSourceOptionAlertController))
        profilePictureImageView.addGestureRecognizer(gesture)
        profilePictureImageView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatePhoneNumberFormattedTextField(sender: Any) {
        if let textField = sender as? UITextField, textField.text != nil {
            let formattedPhoneNumber = textField.text!.formatPhoneNumber() ?? textField.text
            textField.text = formattedPhoneNumber!
        }
    }
    
    // MARK: Functions
    func configureUI(with contact: Contact) {
        if let image = contact.profilePictureImage {
            profilePictureImageView.image = UIImage(data: image as Data)
        }
        
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
    
    func isValidChange() -> Bool {
        guard firstNameTextField.text != "" && lastNameTextField.text != "" else {
            return false
        }
        return true
    }
    
    func unwindSegue() {
        self.performSegue(withIdentifier: "unwindToContactsTableViewController", sender: self)
    }

}

