//
//  NetworkError.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/25/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case decodingError
    case unexpectedError(error: Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("Unable to create URL to download dessert properties", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Failed to receive valid response from server.", comment: "")
        case .decodingError:
            return NSLocalizedString("Failed to decode dessert properties object.", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
        }
    }
}

extension NetworkError: Identifiable {
    var id: String? {
        errorDescription
    }
}
