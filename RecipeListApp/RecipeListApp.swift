//
//  RecipeListAppApp.swift
//  RecipeListApp
//
//  Created by Princess  on 26/09/2021.
//

import SwiftUI

@main
struct RecipeListApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RecipeTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
