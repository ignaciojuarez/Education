//
//  Old DispatchQueue.swift
//  Education
//
//  Created by Ignacio Juarez on 9/7/24.
//

import Foundation
import UIKit
import SwiftUI

enum OldNetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct OldNetworkService {
    
    func oldFetchImage(from urlString: String, completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else { return }
            completionHandler(image, nil)
        }
        .resume()
    }
}

class oldViewModel: ObservableObject {
    @Published var mainImage: UIImage?
    private let netService = OldNetworkService()
    
    func getImage(){
        netService.oldFetchImage(from: "https://picsum.photos/200") { image, error in
            DispatchQueue.main.async {
                self.mainImage = image
            }
        }
    }
}

struct oldView: View {
    @StateObject private var vm = oldViewModel()
    
    var body: some View {
        VStack {
            if let image = vm.mainImage {
                Image(uiImage: image)
            }
        }
        .onAppear(){
            vm.getImage()
        }
    }
}

#Preview {
    oldView()
}
