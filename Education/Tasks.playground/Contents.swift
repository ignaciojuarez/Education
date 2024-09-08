import UIKit


func fetchData(from urlString: String) async throws -> Data {
    guard let url = URL(string: urlString) else {
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    
    return data
}

var profilePicture: UIImage?

func getAsyncImage() async {
    let data = try? await fetchData(from: "https://api.github.com/users/ignaciojuarez")
    profilePicture = UIImage(data: data!) ?? nil
}


// these run almost at the same time. They are
Task() {await getAsyncImage}
Task() {await getAsyncImage}
