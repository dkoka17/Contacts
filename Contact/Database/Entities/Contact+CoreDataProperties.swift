//
//  Contact+CoreDataProperties.swift
//  Contact
//
//  Created by dato on 1/10/21.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?

}

extension Contact : Identifiable {

}
