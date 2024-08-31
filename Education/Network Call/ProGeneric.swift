//
//  Generic.swift
//  Education
//
//  Created by Ignacio Juarez on 8/30/24.
//

import Foundation

// Define an error type for network-related errors.
enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError
    case invalidResponse
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Unable to perform request", comment: "badRequestError")
        case .serverError(let errorMessage):
            return NSLocalizedString(errorMessage, comment: "serverError")
        case .decodingError:
            return NSLocalizedString("Unable to decode successfully.", comment: "decodingError")
        case .invalidResponse:
            return NSLocalizedString("Invalid response", comment: "invalidResponse")
        }
    }
}

// HTTP Method definition for use in network requests.
enum ProHTTPMethod {
    case get(URLQueryItem)
    case post(Data?)
    case delete
    case put(Data?)

    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        case .put:
            return "PUT"
        }
    }
}

// Define a Resource type to encapsulate details needed for network requests.
struct ProResource<T: Codable> {
    let url: URL
    let method: ProHTTPMethod
}

// HTTP Client for performing network requests.
struct ProHTTPClient {
    func load<T: Codable>(_ resource: ProResource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .get(let queryItems):
                var urlComponents = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                urlComponents?.queryItems = [queryItems]
                guard let url = urlComponents?.url else {
                    throw NetworkError.badRequest
                }
                request = URLRequest(url: url)
            case .post(let data), .put(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            case .delete:
                request.httpMethod = resource.method.name
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        
        // Ensure we have a valid HTTP response
        guard let httpResponse = response as? HTTPURLResponse else { throw
            NetworkError.invalidResponse
        }
        
        // Check for HTTP errors
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError("Server error with code: \(httpResponse.statusCode)")
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
