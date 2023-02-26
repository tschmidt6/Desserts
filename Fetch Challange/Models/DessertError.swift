//
//  DessertError.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/22/23.
//

import Foundation

enum DessertError: Error {
    case wrongDataFormat(error: Error)
    case invalidResponse
    case creationError
    case batchInsertError
    case batchDeleteError
    case persistentHistoryChangeError
    case unexpectedError(error: Error)
}

extension DessertError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .wrongDataFormat(let error):
            return NSLocalizedString("Could not digest the fetched data. \(error.localizedDescription)", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Failed to receive valid response from server.", comment: "")
        case .creationError:
            return NSLocalizedString("Failed to create a new Dessert object.", comment: "")
        case .batchInsertError:
            return NSLocalizedString("Failed to execute a batch insert request.", comment: "")
        case .batchDeleteError:
            return NSLocalizedString("Failed to execute a batch delete request.", comment: "")
        case .persistentHistoryChangeError:
            return NSLocalizedString("Failed to execute a persistent history change request.", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
        }
    }
}

extension DessertError: Identifiable {
    var id: String? {
        errorDescription
    }
}
