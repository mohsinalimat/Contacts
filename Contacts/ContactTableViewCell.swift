//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/29/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePictureImageView.layer.cornerRadius = 19
    }
    
    func configureUICell(contact: Contact) {
        if let image = contact.profilePictureImage {
            profilePictureImageView.image = UIImage(data: image as Data)
        }
        let firstName = contact.firstName ?? ""
        let lastName = contact.lastName ?? ""
        let fullName = firstName + " " + lastName
        fullNameLabel.text = fullName
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
