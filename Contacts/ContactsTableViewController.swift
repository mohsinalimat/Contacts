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
    
    var coreDataStack: CoreDataStack!

    var contacts: [Contact] = [] {
        didSet {
            print("contacts didset \(contacts)")
            print(contacts)
            tableView.reloadData()
        }
    }
    
    @IBAction func addContact(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EditContact", bundle: nil)
        let addContactViewController = storyboard.instantiateInitialViewController()!
        self.present(addContactViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.coreDataStack = appDelegate.coreDataStack
        
        fetchContacts { (contacts: [Contact]?, error: NSError?) in
            guard error == nil else { return }
            guard let escapedContacts = contacts else { return }
            self.contacts = escapedContacts
        }
        
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
    
    func fetchContacts(completion: @escaping (_ contacts: [Contact]?,_ error: NSError?) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            let results = try coreDataStack.managedObjectContext.fetch(fetchRequest) as! [Contact]
            completion(results, nil)
        } catch let error as NSError {
            completion(nil, error)
        }
    }
    
    func saveContact(with dictionary: [String: Any], completion: (_ object: NSManagedObject?,_ error: NSError?) -> Void) {
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 28
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contacts.count != 0 {
            return contacts.count
        } else {
            return 10
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(section)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var sections: [String] = []
        for i in 0..<28 {
            sections.append(String(i))
        }
        return sections
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact's cell", for: indexPath) as! ContactTableViewCell
        
        if contacts.count != 0 {
            let contact = contacts[indexPath.row]
            let firstName = contact.value(forKey: "firstName") as! String
            let lastName = contact.value(forKey: "lastName") as! String
            let fullName = firstName + "  " + lastName
            cell.fullNameLabel.text = fullName
            return cell
        } else {
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "contact's detail segue", sender: self)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindToContactsTableViewController(segue: UIStoryboardSegue) {
        print(segue.identifier!)
        if segue.identifier == "done"{
            let editViewController = segue.source as? EditContactTableViewController
            print(editViewController.debugDescription)
            
            // FIXME: - Write date on core data
        }
        tableView.reloadData()
    }

}
