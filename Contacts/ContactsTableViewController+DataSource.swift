//
//  ContactsTableViewController+DataSource.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/30/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import UIKit

extension ContactsTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(section)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var sections: [String] = []
        for i in 0..<(fetchedResultsController.sections?.count ?? 0) {
            sections.append(String(i))
        }
        return sections
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact's cell", for: indexPath) as! ContactTableViewCell
        let contact = fetchedResultsController.object(at: indexPath)
        let firstName = contact.value(forKey: "firstName") as! String
        let lastName = contact.value(forKey: "lastName") as! String
        let fullName = firstName + "  " + lastName
        cell.fullNameLabel.text = fullName
        return cell
    }
}
