//
//  Generic.swift
//  Education
//
//  Created by Ignacio Juarez on 8/30/24.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct HTTPClient {
    
    func fetchData<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw HTTPError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw HTTPError.invalidData
        }
    }
}
