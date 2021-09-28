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
            
            Text("Featured View")
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
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
