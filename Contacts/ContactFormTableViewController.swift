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
    
    // MARK: - IBActions
    
    @IBAction func cancelContact(_ sender: Any) {
        unwindSegue()
    }
    
    @IBAction func saveContact(_ sender: Any) {
        guard isContactValid() else {
            return
        }
        
        if let contact = contact {
            modifyContact(contact: contact)
        } else {
            createContact()
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
    
    // Mark: - ImageViews
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    // MARK: - TextFields
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Buttons
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    // MARK: - Cells
    @IBOutlet weak var deleteCell: UITableViewCell!
    
    
    // MARK: - Life cycles
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
    
    // MARK: - Functions
    func configureUI(with contact: Contact) {
        if let image = contact.profilePictureImage { profilePictureImageView.image = UIImage(data: image as Data) }
        if let firstName = contact.firstName { firstNameTextField.text = firstName }
        if let lastName = contact.lastName { lastNameTextField.text = lastName }
        if let phoneNumber = contact.phoneNumber { mobileTextField.text = phoneNumber }
        if let email = contact.email { emailTextField.text = email }
    }
    
    func unwindSegue() {
        self.performSegue(withIdentifier: "unwindToContactsTableViewController", sender: self)
    }

}

