//
//  ContactTableViewController+Delegate.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/30/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import UIKit

extension ContactsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "contact's detail segue", sender: self)
    }
}
