//
//  NetworkManager.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/24/23.
//

import Foundation
import OSLog

class DessertClient {
    
    /// A shared dessert client for use within the main app bundle.
    static let shared = DessertClient()
    
    // MARK: Logging

    let logger = Logger(subsystem: "com.example.Fetch-Challenge.Desserts", category: "Networking")
    
    private let dessertFeedURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
    private let dessertPropertiesBaseURL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php")! // ?i=52767
    
    // Fetches the desserts from the remote server
    func fetchDesserts() async throws -> [DessertApiObject] {        
        guard let (data, response) = try? await URLSession.shared.data(from: dessertFeedURL),
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            logger.debug("Failed to received valid response and/or data.")
            throw NetworkError.invalidResponse
        }

        do {
            // Decode the dessert feed
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
            let desserts = try jsonDecoder.decode(DessertApiObjectContainer.self, from: data)

            return desserts.meals
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // Fetches the dessert properties specified by the idMeal
    func downloadDessertProperties(idMeal: String) async throws -> DessertProperties? {
            let meal = URLQueryItem(name: "i", value: idMeal)
            let url = dessertPropertiesBaseURL.appending(queryItems: [meal])
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
            
            // Go fetch the Dessert Properties
            guard let (data, response) = try? await URLSession.shared.data(for: request),
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                logger.debug("Failed to received valid response and/or data.")
                throw NetworkError.invalidResponse
            }

        do {
            // Decode the dessert properties.
            let jsonDecoder = JSONDecoder()
            let properties = try jsonDecoder.decode(DessertPropertiesContainer.self, from: data)
            
            guard let dessertProperties = properties.meals.first else {
                throw NetworkError.invalidResponse
            }
            return dessertProperties
        } catch {
            logger.error("*** An error occurred while loading the dessert properties: \(error.localizedDescription) ***")
            throw NetworkError.decodingError
        }
    }
}


