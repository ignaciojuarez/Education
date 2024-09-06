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
    @Published var followers: [GitUser] = []
    private var networkService = NetworkService()
    
    public func loadGitUser() async {
        do {
            let gitAPI = "https://api.github.com/users/ignaciojuarez"
            gitUser = try await networkService.fetch(from: gitAPI)
        } catch {
            print("Error fetching user: \(error)")
        }
    }
    
    public func loadGitFollowers() async {
        do {
            let followersAPI = "https://api.github.com/users/ignaciojuarez/followers"
            followers = try await networkService.fetch(from: followersAPI)
        } catch {
            print("Error fetching followers: \(error)")
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
        VStack {
            Text(viewModel.gitUser?.login ?? "Loading")
            Text("followers: \(viewModel.followers.count)")
            
            ForEach(viewModel.followers, id: \.login) { follower in
                Text(follower.login)
            }
            
            AsyncImage(url: URL(string: viewModel.gitUser?.avatarUrl ?? ""), scale: 2)
        }
        .task {
            await viewModel.loadGitUser()
            await viewModel.loadGitFollowers()
        }
    }
}

#Preview {
    GitView()
}
