//
//  String+DateFormatter.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation

extension String {
    func formatToDate() -> Date {
        let formatter = DateFormatter()
        // not sure the hour format is k or H
        formatter.dateFormat = "y-M-dd'T'k:mm:ss.SSS'Z'"
        return formatter.date(from: self)!
    }
}
