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
    @Published var followers: [GitUser]? = []
    private var networkService = NetworkService()
    
    public func loadScreenGitData() async {
        async let fetchedGitUser = loadGitUser()
        async let fetchedFollowers = loadGitFollowers()
        
        // Await both requests to complete
        let newGitUser = await fetchedGitUser
        let newFollowers = await fetchedFollowers
        
        await MainActor.run {
            self.gitUser = newGitUser
            self.followers = newFollowers
        }
    }
    
    public func loadGitUser() async -> GitUser? {
        do {
            let gitAPI = "https://api.github.com/users/ignaciojuarez"
            let newGitUser: GitUser = try await networkService.fetch(from: gitAPI)
            return newGitUser
        } catch {
            print("Error fetching user: \(error)")
        }
        return nil
    }
    
    public func loadGitFollowers() async -> [GitUser]? {
        do {
            let followersAPI = "https://api.github.com/users/ignaciojuarez/followers"
            followers = try await networkService.fetch(from: followersAPI)
            return followers
        } catch {
            print("Error fetching followers: \(error)")
        }
        return nil
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
            Text("followers: \(viewModel.followers?.count ?? 0)")
            
            ForEach(viewModel.followers ?? [], id: \.login) { follower in
                followerView(name: follower.login)
            }
            
            AsyncImage(url: URL(string: viewModel.gitUser?.avatarUrl ?? ""), scale: 2)
        }
        .task {
            await viewModel.loadScreenGitData()
        }
    }
    
    func followerView(name: String) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 350, height: 30)
                .foregroundStyle(.gray)
                .cornerRadius(10.0)
            
            HStack {
                Text(name)
                    .foregroundStyle(.white)
                    .monospaced()
            }
        }
    }
}

#Preview {
    GitView()
}
