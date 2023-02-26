//
//  DessertPropertiesAPIObject.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/25/23.
//

import Foundation
import OSLog

/// A struct for decoding JSON with the following structure:
///
///{
///  "meals": [
///    {
///      "idMeal": "52767",
///      "strMeal": "Bakewell tart",
///      "strDrinkAlternate": null,
///      "strCategory": "Dessert",
///      "strArea": "British",
///      "strInstructions": "To make the pastry, measure the flour into a bowl and rub in the butter with your fingertips until the mixture resembles fine breadcrumbs. Add the water, mixing to form a soft dough.\r\nRoll out the dough on a lightly floured work surface and use to line a 20cm/8in flan tin. Leave in the fridge to chill for 30 minutes.\r\nPreheat the oven to 200C/400F/Gas 6 (180C fan).\r\nLine the pastry case with foil and fill with baking beans. Bake blind for about 15 minutes, then remove the beans and foil and cook for a further five minutes to dry out the base.\r\nFor the filing, spread the base of the flan generously with raspberry jam.\r\nMelt the butter in a pan, take off the heat and then stir in the sugar. Add ground almonds, egg and almond extract. Pour into the flan tin and sprinkle over the flaked almonds.\r\nBake for about 35 minutes. If the almonds seem to be browning too quickly, cover the tart loosely with foil to prevent them burning.",
///      "strMealThumb": "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg",
///      "strTags": "Tart,Baking,Alcoholic",
///      "strYoutube": "https://www.youtube.com/watch?v=1ahpSTf_Pvk",
///      "strIngredient1": "plain flour",
///      "strIngredient2": "chilled butter",
///      "strIngredient3": "cold water",
///      "strIngredient4": "raspberry jam",
///      "strIngredient5": "butter",
///      "strIngredient6": "caster sugar",
///      "strIngredient7": "ground almonds",
///      "strIngredient8": "free-range egg, beaten",
///      "strIngredient9": "almond extract",
///      "strIngredient10": "flaked almonds",
///      "strIngredient11": "",
///      "strIngredient12": "",
///      "strIngredient13": "",
///      "strIngredient14": "",
///      "strIngredient15": "",
///      "strIngredient16": null,
///      "strIngredient17": null,
///      "strIngredient18": null,
///      "strIngredient19": null,
///      "strIngredient20": null,
///      "strMeasure1": "175g/6oz",
///      "strMeasure2": "75g/2½oz",
///      "strMeasure3": "2-3 tbsp",
///      "strMeasure4": "1 tbsp",
///      "strMeasure5": "125g/4½oz",
///      "strMeasure6": "125g/4½oz",
///      "strMeasure7": "125g/4½oz",
///      "strMeasure8": "1",
///      "strMeasure9": "½ tsp",
///      "strMeasure10": "50g/1¾oz",
///      "strMeasure11": "",
///      "strMeasure12": "",
///      "strMeasure13": "",
///      "strMeasure14": "",
///      "strMeasure15": "",
///      "strMeasure16": null,
///      "strMeasure17": null,
///      "strMeasure18": null,
///      "strMeasure19": null,
///      "strMeasure20": null,
///      "strSource": null,
///      "strImageSource": null,
///      "strCreativeCommonsConfirmed": null,
///      "dateModified": null
///    }
///  ]
///}
struct DessertPropertiesContainer: Decodable {
    var meals: [DessertProperties]
}

struct DessertProperties: Decodable {
    
    var tags: String?
    var instructions: String?
    var ingredients: [String] = []
    var measurements: [String] = []

    enum CodingKeys: CodingKey {
        case strTags
        case strInstructions
    }
    
    // Special struct for decoding ingredients and measurements
    private struct CK : CodingKey {
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawTags = try? container.decode(String.self, forKey: .strTags)
        let rawInstructions = try? container.decode(String.self, forKey: .strInstructions)
        
        let containerCK = try decoder.container(keyedBy: CK.self)
        var rawIngredients: [String] = []
        var rawMeasurements: [String] = []
        for index in 1...20 {
            let rawIngredient = try? containerCK.decode(String.self, forKey: CK(stringValue: "strIngredient\(index)")!)
            let rawMeasurement = try? containerCK.decode(String.self, forKey: CK(stringValue: "strMeasure\(index)")!)
            if rawIngredient?.isEmpty == false && rawMeasurement?.isEmpty == false {
                rawIngredients.append(rawIngredient!)
                rawMeasurements.append(rawMeasurement!)
            }
        }
        
        guard let instructions = rawInstructions
        else {
            let values = "instructions = \(rawInstructions?.description ?? "nil") "

            let logger = Logger(subsystem: "com.example.fetch-Challenge.Desserts", category: "parsing")
            logger.debug("Ignored: \(values)")
            
            throw DessertError.creationError
        }
        
        self.tags = rawTags
        self.instructions = instructions
        self.ingredients = rawIngredients
        self.measurements = rawMeasurements
    }
}
