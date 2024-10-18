//
//  ApiError.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 18..
//

import Foundation
import Moya

enum ApiError: Error, LocalizedError {
    case badUrl
    case noData
    case invalidResponse(statusCode: Int)
    case decodingError
    case unknown(Error)
    case moyaError(MoyaError)
    
    
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "The URL provided was invalid."
        case .noData:
            return "No data was received from the server."
        case .invalidResponse(let statusCode):
            return "Received an invalid response from the server with statuscode: \(statusCode)"
        case .decodingError:
            return "Failed to deccode the response data."
        case .unknown(let error):
            return error.localizedDescription
        case .moyaError(let error):
            return error.errorDescription
        }
    }
}
