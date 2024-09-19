//
//  GenericView.swift
//  Education
//
//  Created by Ignacio Juarez on 8/30/24.
//

import SwiftUI

// Placeholder for the Order model.
struct Order: Codable {
    var id: Int?
    var description: String
}


// Observable object for a coffee store application.
class CoffeeStore: ObservableObject {
    let httpClient: ProHTTPClient
    private var ordersDictionary: [Int: Order] = [:]
    
    init(httpClient: HTTPClient) {
        self.httpClient = ProHTTPClient()
    }
    
    var orders: [Order] {
        Array(ordersDictionary.values)
    }
    
    func loadOrders() async throws {
        let urlString = "https://example.com/orders"
        let orders: [Order] = try await httpClient.fetch(from: urlString)
        for order in orders {
            if let orderId = order.id {
                ordersDictionary[orderId] = order
            }
        }
    }
}

// Sample SwiftUI View.
struct ContentView: View {
    @StateObject var coffeeStore = CoffeeStore(httpClient: HTTPClient())

    var body: some View {
        List(coffeeStore.orders, id: \.id) { order in
            Text(order.description)
        }
        .task {
            try? await coffeeStore.loadOrders()
        }
    }
}

#Preview {
    ContentView()
}
