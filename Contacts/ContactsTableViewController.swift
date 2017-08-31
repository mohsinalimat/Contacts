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
    
    var coreDataStack: CoreDataStack!
    
    var fetchedResultsController: NSFetchedResultsController<Contact>!
    
    @IBAction func addContact(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EditContact", bundle: nil)
        let addContactViewController = storyboard.instantiateInitialViewController()!
        self.present(addContactViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.coreDataStack = appDelegate.coreDataStack
        
        fetchContacts()
        tableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "contact's cell")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - Cored data source
    
    
    
    func fetchContacts(type: ContactsType = .all) {
        
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        if type == ContactsType.favorites {
            fetchRequest.predicate = NSPredicate(format: "favorite == %d", true as CVarArg)
        }
        
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Contact.firstName), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

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
