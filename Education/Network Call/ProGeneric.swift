//
//  Generic.swift
//  Education
//
//  Created by Ignacio Juarez on 8/30/24.
//

import Foundation

// Define an error type for network-related errors.
enum ProNetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// HTTP Client for performing network requests.
struct ProHTTPClient {
    
    private var encoder: JSONEncoder = JSONEncoder()
    
    private var headers: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    public func fetch<T: Codable>(from urlString: String) async throws -> T {
        return try await sendRequest(urlString: urlString, method: .get, body: nil as Data?)
    }
    
    public func putData<T: Codable, U: Codable>(to urlString: String, body: T) async throws -> U {
        let data = try encoder.encode(body)
        return try await sendRequest(urlString: urlString, method: .put, body: data)
    }
    
    public func delete<T: Codable>(from urlString: String) async throws -> T {
        return try await sendRequest(urlString: urlString, method: .delete, body: nil as Data?)
    }
    
    private func sendRequest<T: Codable>(urlString: String, method: HTTPMethod, body: Data?) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        // Apply headers
        for (headerField, value) in headers {
            request.setValue(value, forHTTPHeaderField: headerField)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw HTTPError.invalidResponse
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw HTTPError.invalidData
        }
    }
}
