//
//  ContactFormTableViewController+ImagePickerController.swift
//  Contacts
//
//  Created by Zulwiyoza Putra on 8/31/17.
//  Copyright © 2017 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import UIKit

extension ContactFormTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setupImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func presentSourceOptionAlertController() {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action: UIAlertAction) in
            self.setupImagePickerController(sourceType: .photoLibrary)
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action: UIAlertAction) in
            self.setupImagePickerController(sourceType: .camera)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(photoLibraryAction)
        controller.addAction(cameraAction)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    //Tells the delegate that the user picked a still image or movie.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profilePictureImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //Tells the delegate that the user cancelled the pick operation.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
}

