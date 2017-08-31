//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableViewController: UITableViewController {
    
    enum ContactsType {
        case all, favorites
    }
    
    lazy var coreDataStack: CoreDataStack = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataStack
    }()
    
    var fetchedResultsController: NSFetchedResultsController<Contact>!
    
    @IBAction func addContact(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ContactForm", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() {
            self.present(controller, animated: true, completion: nil)
        } else {
            fatalError("No view controller in initial view")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchContacts()
        
        tableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "contact's cell")
        
    }
    
    // Mark: - Core data source
    
    func fetchContacts(type: ContactsType = .all) {
        
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        if type == ContactsType.favorites {
            fetchRequest.predicate = NSPredicate(format: "favorite == %d", true as CVarArg)
        }
        
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Contact.firstName), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedObjectContext, sectionNameKeyPath: #keyPath(Contact.initialCharacter), cacheName: nil)

        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let error as NSError {
            fatalError("unresolved error: \(error.userInfo)")
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "contact's detail segue") {
            
            if let indexPath = tableView.indexPathForSelectedRow{
                let controller = segue.destination as! ContactDetailTableViewController
                controller.contact = fetchedResultsController.object(at: indexPath)
            }
        }
    }
    
    @IBAction func unwindToContactsTableViewController(segue: UIStoryboardSegue) {
        fetchContacts()
    }

}
