import UIKit

// -----------------------------------
// when using 'in' in closures, the value is saved
// without 'in' = Juarez

var name = "Ignacio"

let closure = { [name] in
    print(name)
}

name = "Juarez"

closure()

// -----------------------------------

func execute() -> (Int) -> Int {
    var input = 0
    
    return { output in
        input = input + output
        return input
    }
}

let op = execute()
let a = op(5)
let b = op(10)
let c = op(15) // ans = 30

// -----------------------------------

class SimpleTimer {
    private var timer: DispatchSourceTimer?
    
    func start(interval: TimeInterval, completion: @escaping () -> Void) {
        stop()
        let timer = DispatchSource.makeTimerSource()    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
}
