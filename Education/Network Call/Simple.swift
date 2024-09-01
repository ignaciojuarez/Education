//
//  NetworkCall.swift
//  Education
//
//  Created by Ignacio Juarez on 8/27/24.
//

import Foundation
import SwiftUI

struct NetworkService {
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
    
    func fetch<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        }
        catch {
            throw NetworkError.invalidData
        }
    }
}

class GitViewModel: ObservableObject {
    @Published var gitUser: GitUser?
    private var networkService = NetworkService()
    
    public func loadGitUser() async {
        do {
            gitUser = try await networkService.fetch(from: "https://api.github.com/users/ignaciojuarez")
        }
        catch {
            
        }
    }
}

struct GitUser: Codable {
    var login: String
    var avatarUrl: String
}

struct GitView: View {
    @StateObject private var viewModel = GitViewModel()
    
    var body: some View {
        HStack {
            Text(viewModel.gitUser?.login ?? "Loading")
            
            AsyncImage(url: URL(string: viewModel.gitUser?.avatarUrl ?? ""))
        }
        .task {
            await viewModel.loadGitUser()
        }
    }
}

#Preview {
    GitView()
}
