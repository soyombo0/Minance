//
//  SavedList+CoreDataProperties.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 6.12.2022.
//
//

import Foundation
import CoreData


extension SavedList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedList> {
        return NSFetchRequest<SavedList>(entityName: "SavedList")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var symbol: String?
    @NSManaged public var imageUrl: URL?
    @NSManaged public var imageData: Data?

}

extension SavedList : Identifiable {
    
}
