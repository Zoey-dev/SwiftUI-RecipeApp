//
//  RecipeTabView.swift
//  RecipeListApp
//
//  Created by Princess  on 28/09/2021.
//

import SwiftUI

struct RecipeTabView: View {
    
    var body: some View {
        TabView {
            
            RecipeFeaturedView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
            
            RecipeListView()
                .tabItem {
                    
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Recipe List")
                    }
                }
            
            
        }
        .environmentObject(RecipeViewModel())
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
