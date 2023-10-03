//
//  APIError.swift
//  iOSPoc
//
//  Created by Lakshmikanth on 02/10/23.
//

import Foundation
class ErrorPack<T: BaseError> {
    public var networkError: NSError?
    public var errorBody: T?
    
    public func errorMessage() -> String {
        if let validationMessage = errorBody?.validationMessage() {
            return validationMessage
        }
        
        if let message = errorBody?.message() {
            return message
        }
        
        if let localizedDescription = networkError?.localizedDescription {
            return localizedDescription
        }
        
        return "An unknown error has occurred."
    }
}

typealias CodableBaseError = BaseError & Codable

class BaseError {
    public func message() -> String? { return "Override me" }
    public func validationMessage() -> String? { return "Override me" }
}

// ********** Myriad API Error Handling ************* //
class APIError: BaseError, Codable {
    public var error: APIErrorBody?
    
    public override func message() -> String? { return error?.message }
    public override func validationMessage() -> String? { return error?.validationMessage() }
}


class APIErrorBody: Codable {
    public var code: Int?
    public var message: String?
    public var validation_messages: [String: [String]]?
    
    public func validationMessage() -> String? {
        guard validation_messages != nil else {
            return message
        }
        
        var messages = [String]()
        
        //Get all messages
        for key in validation_messages!.keys {
            let arrayForKey = validation_messages![key] ?? []
            messages.append(contentsOf: arrayForKey)
        }
        
        return messages.joined(separator: "\n")
    }
}

class APIValidationMessage: Codable {
    public var code: String?
    public var message: String?
}
