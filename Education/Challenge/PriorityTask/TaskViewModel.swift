//
//  TaskManager.swift
//  Education
//
//  Created by Ignacio Juarez on 9/10/24.
//

import Foundation

enum Priority: Int {
    case low = 1
    case medium = 2
    case high = 3
}

struct Task {
    var name: String
    let dueDate: Date
    var priority: Priority?
    
    init(name: String, dueDate: Date, priority: Priority) {
        self.name = name
        self.dueDate = dueDate
        self.priority = priority
    }
}

struct TaskGroup {
    var name: String
    var tasks: [Task]
}

//class TaskViewModel: ObservableObject {
//    
//    @Published var allTasks: [Task]
//    
//    init() {
//        
//    }
//    
//    func addTask(task: Task) {
//    }
//    
//    func getSortedTasks() -> [Task] {
//        var priorityTasks: [Task] = []
//        
//        var withPriority: [Task] = allTasks.filter{$0.priority != nil}
//                                           .sorted {$0.priority!.rawValue > $1.priority!.rawValue}
//        
//        var withDate: [Task] = allTasks.sorted{$0.dueDate < $1.dueDate}
//        
//        withPriority.forEach { priorityTasks.append($0) }
//        withDate.forEach { priorityTasks.append($0) }
//
//        for task in allTasks {
//            if priorityTasks
//        }
//        
//        
//    }
//}


