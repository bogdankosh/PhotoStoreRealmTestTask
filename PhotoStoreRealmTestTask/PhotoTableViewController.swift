//
//  PhotoTableViewController.swift
//  PhotoStoreRealmTestTask
//
//  Created by Bogdan Koshyrets on 9/14/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
}

class PhotoTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var realm: Realm!
    let photoManager = PhotoManager()
    
    let picker = UIImagePickerController()
    
    func photoFromLibrary() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        setupUI()
        setupRealm()
        
        addSamplePhoto()
        
//        let photoData = photoManager.loadDataFromDocumentsFolder(fileName: photo.linkString)
//        let image = UIImage(data: photoData)!
//        print(image.description)
    }
    
    func setupUI() {
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.identifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(photoFromLibrary))
    }
    
    func addSamplePhoto() {
        let photo = Photo()
        
        do {
            let data = try Data(contentsOf: URL(string: "https://www.gravatar.com/avatar/876f7ddaf27a16c17a62b8a9705b45f1?s=32&d=identicon&r=PG&f=1")!)
            if let image = UIImage(data: data) {
                photoManager.saveImageToDocumentsFolder(image, fileName: photo.linkString)
            }
        } catch {
            print("Cannot obtain image from URL")
        }
        saveToRealm(photo)

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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath)

        // Configure the cell...

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
    
    // MARK: - UIImagePickerController data source
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(image.description)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
