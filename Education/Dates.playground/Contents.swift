import Foundation

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"


let currentDate = Date()
let dateString = dateFormatter.string(from: currentDate)

print("Formatted Date String: \(dateString)")

//--------------------------------------------

struct Note {
    var text: String
    var date: Date
}

let notes = [
    Note(text: "Grocery shopping", date: Date()),
    Note(text: "Doctor's appointment", date: Date().addingTimeInterval(-86400)),
    Note(text: "Meeting with team", date: Date().addingTimeInterval(86400 * 2))
]

let sortedNotes = notes.sorted(by: { $0.date < $1.date })


