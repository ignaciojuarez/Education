//
//  GenericView.swift
//  Education
//
//  Created by Ignacio Juarez on 8/30/24.
//

import SwiftUI

// Placeholder for the Order model.
struct Recepit: Codable, Identifiable {
    var id: Int
    var cost: Int
    var description: String
}

// Observable object for a coffee store application.
class Store: ObservableObject {
    private let httpClient = HTTPClient()
    @Published var recepits: [Recepit] = []
    
    func fetchRecepits() async throws {
        recepits = try await httpClient.fetchData(from: "https://api.example.com/data")
        
        for recepit in recepits {
            print(recepit)
        }
    }
    
    func fetchMultipleURLs<T:Codable>(from urls: [String]) async -> [T] {
        var gatheredRecepits: [T] = []
        
        await withTaskGroup(of: T?.self) { group in
            for url in urls {
                group.addTask {
                    try? await self.fetchNetworkCall(from: url)
                }
            }
            
            for await result in group {
                if let product = result {
                    gatheredRecepits.append(product)
                }
            }
        }
        return gatheredRecepits
    }
    
    // invalidResponse return error code
    // custom headers?
    // enum networkAction .get, .put, .delete, ...
    //
    func fetchNetworkCall<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw HTTPError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        }
        catch {
            throw HTTPError.invalidData
        }
        
    }
}

// Sample SwiftUI View.
struct StoreView: View {
    @StateObject var store = Store()

    var body: some View {
        List(store.recepits) { recepit in
            Text(recepit.description)
        }
        .task {
            do {
                try await store.fetchRecepits()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    StoreView()
}
