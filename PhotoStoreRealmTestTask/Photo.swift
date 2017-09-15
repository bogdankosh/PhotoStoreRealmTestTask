//
//  Photo.swift
//  PhotoStoreRealmTestTask
//
//  Created by Bogdan Koshyrets on 9/14/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object {
    dynamic var name            = ""
    dynamic var sectionTitle    = ""
    dynamic var date            = Date()
    dynamic var linkString      = UUID().uuidString
    dynamic var thumbnailString = UUID().uuidString
    
}
