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

    var contacts: [NSManagedObject] = [] {
        didSet {
            print("contacts didset \(contacts)")
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
        
        //
        
        fetchContacts { (objects: [NSManagedObject]?, error: NSError?) in
            guard error == nil else { return }
            guard let escapedObjects = objects else { return }
            self.contacts = escapedObjects
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
    
    func fetchContacts(completion: (_ objects: [NSManagedObject]?,_ error: NSError?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        
        do {
            let objects = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            completion(objects, nil)
        } catch let error as NSError {
            completion(nil, error)
        }
    }
    
    func saveContact(with dictionary: [String: Any], completion: (_ object: NSManagedObject?,_ error: NSError?) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedObjectContext) else { return }
        let object = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        entity.setValue(dictionary["phoneNumber"], forKey: "phoneNumber")
        entity.setValue(dictionary["firstName"], forKey: "firstName")
        entity.setValue(dictionary["lastName"], forKey: "lastName")
        entity.setValue(dictionary["email"], forKey: "email")
        
        do {
            try managedObjectContext.save()
            contacts.append(object)
            completion(object, nil)
        } catch let error as NSError {
            completion(nil, error)
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 28
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToContactsTableViewController(segue: UIStoryboardSegue) {
        print(segue.identifier!)
        if segue.identifier == "done"{
            let editViewController = segue.source as? EditContactTableViewController
            
            // FIXME: - Write date on core data
        }
        tableView.reloadData()
    }

}
