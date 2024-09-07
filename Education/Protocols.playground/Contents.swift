import UIKit

class Circle: Figure {
    let edges = 0
    
    func draw() -> String {
        return "()"
    }
}

class Square: Figure {
    let edges = 4
    
    func draw() -> String {
        return "[]"
    }
}

protocol Figure {
    var edges: Int {get}
    func draw() -> String
}

class WhiteboardDrawingViewModel: ObservableObject {
    
    let CircleInstance: Circle = Circle()
    let SquareInstance: Square = Square()
    
    enum figureTypes {
        case Square
        case Circle
    }
    
    func returnRandomFigure(which figureType: figureTypes) -> some Figure {
        let random: Int = Int.random(in: 0...1)
        //if random == 1 {return Circle()}
        return Square()
    }
}
