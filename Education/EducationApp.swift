//
//  EducationApp.swift
//  Education
//
//  Created by Ignacio Juarez on 8/26/24.
//

import SwiftUI

@main
struct EducationApp: App {
    
    private let provider = CoreDataProvider()
    
    var body: some Scene {
        WindowGroup {
            //GitView()
            
//            TestingCoreData()
//                .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
            
            EventView()
        }
    }
}
