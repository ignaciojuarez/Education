
import Foundation

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"


let currentDate = Date()
let dateString = dateFormatter.string(from: currentDate)

print("Formatted Date String: \(dateString)")


