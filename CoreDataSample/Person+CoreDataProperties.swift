//
//  Person+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by Kap's on 30/06/20.
//  Copyright © 2020 Kapil. All rights reserved.
//
//

import Foundation
import CoreData

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
