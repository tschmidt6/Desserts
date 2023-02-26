//
//  Dessert.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/22/23.
//

import CoreData
import SwiftUI
import OSLog

// MARK: - Core Data

/// Managed object subclass for the Dessert entity.
class Dessert: NSManagedObject {
    
    // The characteristics of a dessert.
    @NSManaged var strMeal: String
    @NSManaged var strMealThumb: String

    // A unique identifier used to avoid duplicates in the persistent store.
    @NSManaged var idMeal: String
}

extension Dessert {
    
    /// An dessert for use with canvas previews.
    static var preview: Dessert {
        let desserts = Dessert.makePreviews(count: 1)
        return desserts[0]
    }

    @discardableResult
    static func makePreviews(count: Int) -> [Dessert] {
        var desserts = [Dessert]()
        let viewContext = DessertProvider.preview.container.viewContext
        for _ in 0..<count {
            let dessert = Dessert(context: viewContext)
            dessert.strMeal = "Apple & Blackberry Crumble"
            dessert.strMealThumb = "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg"
            dessert.idMeal = "52893"
            desserts.append(dessert)
        }
        return desserts
    }
}
