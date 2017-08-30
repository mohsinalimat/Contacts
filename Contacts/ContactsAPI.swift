//
//  ContactsAPI.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation

class ContactsAPI: NSObject {
    

    enum Request { case get, post, put }
    
    enum Method { case contacts, contact }
    
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
