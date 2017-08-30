//
//  ContactsAPI.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation

class ContactsAPI: NSObject {
    
    var contacts: [Contact] = []
    
    enum Request { case GET, POST, PUT }
    
    enum Method { case Contacts, Contact }
    
    // Shared session
    var session = URLSession.shared
    
    // Get contacts
    func Contacts(request: Request.Type) {
        
    }
    
    // MARK: Shared Instance
    class func shared() -> ContactsAPI {
        struct Singleton {
            static var sharedInstance = ContactsAPI()
        }
        return Singleton.sharedInstance
    }
}
