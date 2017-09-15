//
//  PhotoManager.swift
//  PhotoStoreRealmTestTask
//
//  Created by Bogdan Koshyrets on 9/15/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import Foundation
import UIKit

struct PhotoManager {    
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
    func loadDataFromDocumentsFolder(fileName: String) -> Data {
        var data = Data()
        let fileManager = FileManager.default
        do {
            let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let path = documentsDirectory.appendingPathComponent(fileName)
            data = try Data(contentsOf: path)
            print("SOMETHING IS IN DATA? \(data)")
        } catch {
            print(#line, error)
        }
        return data
    }
}
