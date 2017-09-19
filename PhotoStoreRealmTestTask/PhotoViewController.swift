//
//  PhotoViewController.swift
//  PhotoStoreRealmTestTask
//
//  Created by Bogdan Koshyrets on 9/16/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit
import RealmSwift

enum SectionType: String {
    case userID = "userid"
    case sertificate = "sertificate"
    case undefined = "undefined"
}

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var realm: Realm!
    
    var photoObject: Photo?
    
    var image: UIImage? = nil {
        didSet {
            print("TRIGGERED")
            imageView.image = image
            createPhoto()
        }
    }
    
    var photo: Photo?
    
    var imageView = UIImageView()
    
    let picker = UIImagePickerController()
    
    var section: SectionType = .undefined {
        didSet {
            print("DID SET TO \(section.rawValue)")
        }
    }
    
    weak var delegate: PhotoTableViewController?
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        // Setting up toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: (view.frame.height - 44), width: view.frame.width, height: 44))
        let button1 = UIBarButtonItem(title: "Camera", style: .plain, target: self, action: #selector(pickPhoto(sender:)))
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let button2 = UIBarButtonItem(title: "Library", style: .plain, target: self, action: #selector(pickPhoto(sender:)))
        toolbar.setItems([button1, flex, button2], animated: true)
        toolbar.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(toolbar)
        
        // Setting up UIImageView
        imageView = UIImageView()
        imageView.image = UIImage(named: "pizza")
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height - 44)
        view.addSubview(imageView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        realm = try! Realm()
        
        if let photoObject = photoObject {
            let data = PhotoManager.loadDataFromDocumentsFolder(fileName: photoObject.linkString)
            imageView.image = UIImage(data: data)
        }
        
        delegate?.heyHO(string: "YAZZZ")
        
    }
    
    func createPhoto() {
        
        if photoObject == nil {
            photo = Photo()
            photo!.sectionTitle = self.section.rawValue
            if let image = image {
                PhotoManager.saveImageToDocumentsFolder(image, fileName: photo!.linkString)
                try! realm.write {
                    realm.add(photo!)
                }
            }
        } else {
            if let image = image {
                PhotoManager.saveImageToDocumentsFolder(image, fileName: photoObject!.linkString)
            }

        }
    }
    
    @objc func pickPhoto(sender: UIBarButtonItem) {
        
        let title = sender.title!
        switch title {
        case "Camera":  picker.sourceType = .camera
        case "Library": picker.sourceType = .photoLibrary
        default: fatalError()
        }
        picker.allowsEditing = false
        
        // TODO: Check if device has a camera

        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Image Picker delegate mothods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.image = image
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
