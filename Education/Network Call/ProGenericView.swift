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
    let httpClient: HTTPClient
    private var ordersDictionary: [Int: Order] = [:]
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    var orders: [Order] {
        Array(ordersDictionary.values)
    }
    
//    func loadOrders() async throws {
//        let resource = Resource(url: "https://example.com/orders")
//        let orders: [Order] = try await httpClient.load(resource)
//        for order in orders {
//            if let orderId = order.id {
//                ordersDictionary[orderId] = order
//            }
//        }
//    }
}

// Sample SwiftUI View.
struct ContentView: View {
    @StateObject var coffeeStore = CoffeeStore(httpClient: HTTPClient())

    var body: some View {
        List(coffeeStore.orders, id: \.id) { order in
            Text(order.description)
        }
        .onAppear {
            Task {
                do {
                    //try await coffeeStore.loadOrders()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
