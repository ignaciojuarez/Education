import UIKit

// MARK: Throw

func getHour() throws -> String {
    return "10AM"
}

func getMinutes() throws -> String {
    if 1 == 2 {
        return "30min"
    } else {
        throw URLError(.badURL)
    }
    
}

// MARK: Try
// - if a try fail's, catch gets executed, the rest of the code doesn't run
// - if Try?(Optional) fails, the rest of the code continues

var time: String? = ""
    
do {
    let hour = try getHour()
    time = hour
    
    let minutes = try? getMinutes()
    time = minutes
    
} catch {
    print(error)
}

// MARK: Try? (Optional)
//  - doesnt need a do{}, because doesnt need a catch{}
//  - if try fails, minutes = nil

let minutes = try? getMinutes()

if let minutes = minutes {
    print("worked!")
}



