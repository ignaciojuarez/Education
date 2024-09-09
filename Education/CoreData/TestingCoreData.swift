//
//  ViewAndModel.swift
//  Education
//
//  Created by Ignacio Juarez on 9/8/24.
//

import Foundation
import CoreData
import SwiftUI

struct TestingCoreData: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var todoItems: FetchedResults<TodoItem>
    @State private var title: String = ""
    
    private var isFormValid: Bool {
        !title.isEmpty || title == ""
    }
    
    private func saveTodoItem() {
        let todoItem = TodoItem(context: context)
        todoItem.title = title
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    private func updateItem() {
        try? context.save()
    }
    
    var body: some View {
        VStack {
            Text("To-Do Core Data")
                .font(.title)
            
            TextField("Title", text: $title)
                .onSubmit {
                    if isFormValid {
                        saveTodoItem()
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                .padding(.top)
            
            List{
                ForEach(todoItems) { todoItem in
                    Text(todoItem.title ?? "error")
                }
            }
        }
    }
    
}

#Preview {
    TestingCoreData()
        .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
}
