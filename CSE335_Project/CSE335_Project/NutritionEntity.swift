//
//  NutritionEntity.swift
//  CSE335_Project
//
//  Created by Truong Vu on 11/15/16.
//  Copyright © 2016 TruongVu. All rights reserved.
//

import Foundation
import CoreData

class NutritionEntity: NSManagedObject
{
    @NSManaged var upcCode: String
    @NSManaged var itemName: String
    @NSManaged var caloriesAmount: String
    @NSManaged var fatAmount: String
    @NSManaged var sodiumAmount: String
    @NSManaged var sugarAmount: String
}