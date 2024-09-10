//
//  EventModel.swift
//  Education
//
//  Created by Ignacio Juarez on 9/9/24.
//

import Foundation

class EventModel: Identifiable {
    var id: UUID
    var title: String
    var description: String
    var startTime: Date
    var endTime: Date
    
    init(id: UUID, title: String, description: String, startTime: Date, endTime: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.startTime = startTime
        self.endTime = endTime
    }
}
