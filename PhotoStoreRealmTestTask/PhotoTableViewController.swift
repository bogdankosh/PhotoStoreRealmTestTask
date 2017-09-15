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
    
}

class PhotoTableViewController: UITableViewController {
    
    var realm: Realm!

    override func viewDidLoad() {
        super.viewDidLoad()

        realm = try! Realm()
//
//        try! realm.write {
//            realm.deleteAll()
//        }
//        
//        let photo1 = Photo()
//        photo1.date = Date()
//        photo1.name = "Photo \(arc4random())"
//        
//        try! realm.write {
//            realm.add(photo1)
//        }
        
        
        let photo = Photo()
        addPhoto(withPath: photo.linkString)
        
        print(photo.linkString)
        print(photo.linkString)
        
        let fileManager = FileManager.default
        do {
            let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let path = documentsDirectory.appendingPathComponent(photo.linkString)
            print(path)
            let data = try Data(contentsOf: path)
            print("SOMETHING IS IN DATA? \(data)")
        } catch {
            print(error)
        }
        
    }
    
    func addPhoto(withPath path: String) {
        do {
            let data = try Data(contentsOf: URL(string: "https://www.gravatar.com/avatar/876f7ddaf27a16c17a62b8a9705b45f1?s=32&d=identicon&r=PG&f=1")!)
            if let image = UIImage(data: data) {
                saveImageToDocumentsFolder(image, fileName: path)
            }
        } catch {
            print("Cannot obtain image from URL")
        }
        
        
    }
    
    func saveImageToDocumentsFolder(_ image: UIImage, fileName: String) {
        let fileManager = FileManager.default
        do {
            let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let filePath = documentsDirectory.appendingPathComponent(fileName)
            if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                do {
                    try imageData.write(to: filePath, options: .atomicWrite)
                    print("FILE PATH IS \(filePath)")
                    print("SUCCESS TO WRITING IMAGE")
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
