//
//  String+EmailFormatValidation.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/31/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegularExpressionFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegularExpressionFormat)
        return email.evaluate(with: self)
    }
}
