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
    dynamic var name = ""
    dynamic var date: Date? = nil
    dynamic var link: String? = nil
//    dynamic var sectionTitle = ""
    dynamic var thumbnail: Data? = nil
}
