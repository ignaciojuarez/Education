
let songTimes1 = [
  ["Stairway to Heaven", "8:05"], ["Immigrant Song", "2:27"],
  ["Rock and Roll", "3:41"], ["Communication Breakdown", "2:29"],
  ["Good Times Bad Times", "2:48"], ["Hot Dog", "3:19"],
  ["The Crunge", "3:18"], ["Achilles Last Stand", "10:26"],
  ["Black Dog", "4:55"]
]
let songTimes2 = [
  ["Stairway to Heaven", "8:05"], ["Immigrant Song", "2:27"],
  ["Rock and Roll", "3:41"], ["Communication Breakdown", "2:29"],
  ["Good Times Bad Times", "2:48"], ["Black Dog", "4:55"],
  ["The Crunge", "3:18"], ["Achilles Last Stand", "10:26"],
  ["The Ocean", "4:31"], ["Hot Dog", "3:19"]
]

func twoSong(songsWithTime: [String:String]) -> [String] {
    
    var dict = [String:String] = [:] //timeLookingfor : Song of the one looking for that time
    
    for songWithTime in songsWithTime {
        let song = songWithTime[0]
        let time = songWithTime[1]
        
        if let lookingSong = dict[time] {
            return [lookingSong, song]
        }
        
        let lookingTime = calculateTimeLookingFor(time)
        dict[lookingTime] = song
    }
}

func calculateTimeLookingFor(_ time: String) -> String {
    let timeParts = time.split(separator: ":")
    let minutes = Int(timeParts[0])!
    let seconds = Int(timeParts[1])!
    // "3:41"
    
    let lookingMinutes = 7 - (minutes - 1)
    let lookingSeconds = 60 - seconds
    
    return("\(lookingMinutes):\(lookingSeconds)"
}
           
print(twoSong(songsWithTime: songTimes1))
