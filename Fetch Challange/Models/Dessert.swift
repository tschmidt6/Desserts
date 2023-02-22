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

// MARK: - Codable

/// A struct for decoding JSON with the following structure:
///
/// {
///    "meals": [
///          {
///          "strMeal":"Apam balik",
///          "strMealThumb":"https:\/\/www.themealdb.com\/images\/media\/meals\/adxcbq1619787919.jpg",
///          "idMeal":"53049"
///         }
///    ]
///}
struct DessertApiObjectWrapper: Decodable {
    var meals: [DessertApiObject]
}
struct DessertApiObject: Decodable {
    var strMeal: String
    var strMealThumb: String

    // A unique identifier used to avoid duplicates in the persistent store.
    var idMeal: String
    
    enum CodingKeys: CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawStrMeal = try? container.decode(String.self, forKey: .strMeal)
        let rawStrMealThumb = try? container.decode(String.self, forKey: .strMealThumb)
        let rawIdMeal = try? container.decode(String.self, forKey: .idMeal)
        
        guard let strMeal = rawStrMeal,
              let strMealThumb = rawStrMealThumb,
              let idMeal = rawIdMeal
        else {
            let values = "strMeal = \(rawStrMeal?.description ?? "nil"), "
            + "strMealThumb = \(rawStrMealThumb?.description ?? "nil"), "
            + "idMeal = \(rawIdMeal?.description ?? "nil")"

            let logger = Logger(subsystem: "com.example.fetch-Challenge.Desserts", category: "parsing")
            logger.debug("Ignored: \(values)")
            
            throw DessertError.missingData
        }
        
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
    
    // The keys must have the same name as the attributes of the Dessert entity.
    var dictionaryValue: [String: Any] {
        [
            "strMeal": strMeal,
            "strMealThumb": strMealThumb,
            "idMeal": idMeal
        ]
    }
}
