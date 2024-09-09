import Foundation

// ------------------------------------
// MARK: - Task, multiple async func() (same time)

//Task {
//    async let firstResult = fetchFirstData()
//    async let secondResult = fetchSecondData()
//    // Both functions run concurrently; the task continues once both have completed.
//    let results = try await (firstResult, secondResult)
//    // Use results...
//}

// ------------------------------------
// MARK: - Thread-Safe Class function

// Custom Dispatch Queue aproach
class ProfileManager {
    private var userProfile: [String: Any] = ["name": "John Doe", "age": 30]
    private let queue = DispatchQueue(label: "profileManager")
    
    func updateProfile(with details: [String: Any]) {
        queue.async {
            for (key, value) in details {
                self.userProfile[key] = value
            }
            // Optionally, you might need to update the UI or other parts of your application
            DispatchQueue.main.async {
                print("Profile updated to: \(self.userProfile)")
            }
        }
    }
}

// Actor: Swift Concurrency aproach
actor ProfileManager2 {
    private var userProfile: [String: Any] = ["name": "John Doe", "age": 30]

    func updateProfile(with details: [String: Any]) async {
        for (key, value) in details {
            userProfile[key] = value
        }
        // If needed, return the updated profile or some result
    }
}

// ----------------------------------------------
