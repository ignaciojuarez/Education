//
//  EventViewModel.swift
//  Education
//
//  Created by Ignacio Juarez on 9/9/24.
//

import Foundation
import SwiftUI

class EventViewModel: ObservableObject {
    
    @Published var events: [UUID:EventModel] // [id : event]
    @Published var eventsArray: [EventModel] = [] // [id : event]
    
    init() {
        events = [:]
    }
    
    func addEvent(title: String? = nil, description: String? = nil, startDate: Date? = nil, endDate: Date? = nil) {
        let newEvent = EventModel(id: UUID(),
                                  title: title ?? "New Event",
                                  description: description ?? "some details...",
                                  startTime: startDate ?? Date(),
                                  endTime: endDate ?? Date())
        events[newEvent.id] = newEvent
    }
    
    func modifyEvent(byId id: UUID) {
        events[id]?.title = "Modified"
    }
    
    func deleteEvent(byId id: UUID) {
        events.removeValue(forKey: id)
    }
    
    func deleteArrayEvent(byId id: UUID) {
        if let event = (eventsArray.first(where: { $0.id == id })) {
            
        }
        
        if let eventIndex = (eventsArray.firstIndex(where: { $0.id == id })) {
            eventsArray.remove(at: eventIndex)
        }
    }
}
