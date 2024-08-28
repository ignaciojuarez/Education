//
//  NetworkCall.swift
//  Education
//
//  Created by Ignacio Juarez on 8/27/24.
//

import Foundation
import SwiftUI

struct User: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}

class GithubViewModel: ObservableObject {
    
    var user: User? = nil
    
    func getUser() async throws -> User? {
        guard let url = URL(string: "https://api.github.com/users/ignaciojuarez") else {
            print("invalid URL")
            return nil
        }
        
        let (data, response) =  try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("invalid response")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(User.self, from: data)
        }
    }
}

struct GithubProfile: View {
    var vm = GithubViewModel()
    
    var body: some View {
        HStack {
            Text(vm.user?.login ?? "Loading")
        }
        .task { vm.user = try await vm.getUser() }
    }
}


