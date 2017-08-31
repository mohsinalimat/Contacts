//
//  ContactDetailTableViewController.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import UIKit

class ContactDetailTableViewController: UITableViewController {

    var contact: Contact!
    
    var defaultBackgroundImage: UIImage? = nil
    var defaultShadowImage: UIImage? = nil
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func editContact(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ContactForm", bundle: nil)
        let navigation = storyboard.instantiateInitialViewController() as! UINavigationController
        let controller = navigation.topViewController as! ContactFormTableViewController
        controller.contact = contact
        self.present(navigation, animated: true) {
            // If necessary do something
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deconfigureUI()
    }
    
    func configureNavigationControllerUI(_ navigationController: UINavigationController) {
        // Save images
        defaultBackgroundImage = navigationController.navigationBar.backgroundImage(for: .default)
        defaultShadowImage = navigationController.navigationBar.shadowImage
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = UIColor.clear
    }
    
    func deconfigureNavigationControllerUI(_ navigationController: UINavigationController) {
        if let image = defaultBackgroundImage {
            navigationController.navigationBar.setBackgroundImage(image, for: .default)
        }
        if let image = defaultShadowImage {
            navigationController.navigationBar.setBackgroundImage(image, for: .default)
        }
        navigationController.navigationBar.isTranslucent = false
        navigationController.view.backgroundColor = UIColor.clear
    }
    
    func configureUI() {
        if let navigationController = self.navigationController {
            configureNavigationControllerUI(navigationController)
        }
        
        fullNameLabel.text = "\(contact.firstName ?? "") \(contact.lastName ?? "")"
        
        if let email = contact.email {
            emailLabel.text = email
        } else {
            emailLabel.text = "Edit to modify email address"
        }
        
        if let phoneNumber = contact.phoneNumber {
            phoneNumberLabel.text = phoneNumber
        } else {
            phoneNumberLabel.text = "Edit to modify phone number"
        }
    }
    
    func deconfigureUI() {
        if let navigationController = self.navigationController {
            deconfigureNavigationControllerUI(navigationController)
        }
    }

}
