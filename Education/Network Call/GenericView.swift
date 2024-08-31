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
