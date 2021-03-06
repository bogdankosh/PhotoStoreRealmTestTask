//
//  PhotoTableViewController.swift
//  PhotoStoreRealmTestTask
//
//  Created by Bogdan Koshyrets on 9/14/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit
import RealmSwift
import WatchConnectivity

class PhotoCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
}

class PhotoTableViewController: UITableViewController {
    
    var realm: Realm!
    let photoManager = PhotoManager()

    var photoStore = [[Photo]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRealm()
        
        // Add two empty placeholders
        for _ in 0 ..< 2 {
            photoStore.append([])
        }
        
        checkDatabase()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkDatabase()
        tableView.reloadData()
    }
    func setupUI() {
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.identifier)
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(photoFromLibrary))
    }
    
    func addSamplePhoto() {
        let photo = Photo()
        
        do {
            let data = try Data(contentsOf: URL(string: "https://www.gravatar.com/avatar/876f7ddaf27a16c17a62b8a9705b45f1?s=32&d=identicon&r=PG&f=1")!)
            if let image = UIImage(data: data) {
                PhotoManager.saveImageToDocumentsFolder(image, fileName: photo.linkString)
            }
        } catch {
            print("Cannot obtain image from URL")
        }
        saveToRealm(photo)

    }
    
    func checkDatabase() {
        let photos = realm.objects(Photo.self).filter("sectionTitle == %s", "userid").sorted(by: { $0.date > $1.date } )
        let certs  = realm.objects(Photo.self).filter("sectionTitle == %s", "sertificate").sorted(by: { $0.date > $1.date } )
        
        // TODO: Create a way to check if [0], [1] exists.
        photoStore[0] = photos
        photoStore[1] = certs
        
        transferPhotosToWatch()
    }
    
    func transferPhotosToWatch() {
        if WCSession.isSupported() {
            var array = [String]()
            for photo in photoStore[0] {
                array.append(photo.date.description)
            }
            let dict = ["photo": array]
            let session = WCSession.default()
            try! session.updateApplicationContext(dict)
        }
    }
    
    
    // MARK: - Realm helper methods
    
    func setupRealm() {
        realm = try! Realm()
    }
    
    func saveToRealm(_ photo: Photo) {
        try! realm.write {
            realm.add(photo)
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableViewSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photoStore[section].count + 1 // Plus Add Photo cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath)

        switch indexPath.row {
        case 0:
            switch indexPath.section {
            case 0: cell.textLabel?.text = "Add Photo"
            case 1: cell.textLabel?.text = "Add Sertificate"
            default: fatalError("There should be only 2 sections.")
            }
        default: cell.textLabel?.text = photoStore[indexPath.section][indexPath.row - 1].date.description
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.tableViewSections[section]
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
    
    
    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let photoController = PhotoViewController()
        photoController.delegate = self
        
        // If the user chooses the photo cell, not create photo/certificate
        if indexPath.row != 0 {
            photoController.photoObject = photoStore[indexPath.section][indexPath.row - 1]
        }
        
        var section = ""
        switch indexPath.section {
        case 0: section = "userid"
        case 1: section = "sertificate"
        default: fatalError("There should be only 2 sections.")
        }
        
        photoController.section = SectionType(rawValue: section)!
        navigationController?.pushViewController(photoController, animated: true)
    }
    
    func heyHO(string: String) {
        print("YAY, \(string)")
    }
}
