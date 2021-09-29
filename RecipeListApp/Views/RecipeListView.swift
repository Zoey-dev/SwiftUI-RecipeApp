//
//  ContentView.swift
//  RecipeListApp
//
//  Created by Princess  on 26/09/2021.
//

import SwiftUI

struct RecipeListView: View {
    
    //refernce to the view model
    @EnvironmentObject var model: RecipeViewModel
    
    var body: some View {
        
        NavigationView {
            List(model.recipes) { r in
                
               NavigationLink(
                destination: RecipeDetailView(recipe: r),
                label: {
                    HStack(spacing: 15.0){
                        Image(r.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaledToFill()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipped()
                        Text(r.name)
                    }
                })
               
            }
            .navigationBarTitle("All Recipes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView().previewDevice("iPhone 12")
    }
}
