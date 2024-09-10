//
//  EventView.swift
//  Education
//
//  Created by Ignacio Juarez on 9/9/24.
//

import Foundation
import SwiftUI

struct EventView: View {
    
    @StateObject private var eventViewModel = EventViewModel()
    
    var body: some View {
        VStack{
            ScrollView {
                ForEach(Array(eventViewModel.events.values)) { event in
                    singleEventView(event: event)
                }
            }
            
        }
        .padding()
        .overlay {
            Button {
                eventViewModel.addEvent()
            } label: {
                ZStack {
                    Circle()
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                }

            }
            .frame(width: 60, height: 60)
            .offset(CGSize(width: 140.0, height: 350.0))
        }
    }
    
    func singleEventView(event: EventModel) -> some View {
        VStack{
            HStack {
                Text(event.title)
                    .font(.subheadline)
                
                Text("\(event.startTime) to \(event.endTime)")
            }
            Text(event.description)
                .font(.caption)
            HStack {
                Spacer()
                Button("Delete") {
                    eventViewModel.deleteEvent(byId: event.id)
                }
            }
            
        }
        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EventView()
}
