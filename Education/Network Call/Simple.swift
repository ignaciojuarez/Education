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
    
    @Published var user: User? = nil
    
    enum GitError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
    
    func fetchGitUser() async throws -> User? {
        let endpoint = "https://api.github.com/users/ignaciojuarez"
        
        guard let url = URL(string: endpoint) else {
            throw GitError.invalidURL
        }
        
        let (data, response) =  try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GitError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(User.self, from: data)
        }
        catch {
            throw GitError.invalidData
        }
    }
}

struct GithubProfile: View {
    @EnvironmentObject var vm: GithubViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: vm.user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .mask { Circle()}
            } placeholder: {
                Circle()
                    
            }
            .frame(width: 100, height: 100)
            
            Text(vm.user?.login ?? "")
            Text(vm.user?.bio ?? "Loading")
        }
        .task {
            do {
                vm.user = try await vm.fetchGitUser()
            } catch {
                print("Error fetching user: \(error)")
            }
        }
    }
}

#Preview {
    GithubProfile()
        .environmentObject(GithubViewModel())
}
