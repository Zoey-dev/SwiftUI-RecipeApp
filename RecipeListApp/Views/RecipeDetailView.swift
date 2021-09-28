//
//  RecipeDetailView.swift
//  RecipeListApp
//
//  Created by Princess  on 28/09/2021.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe:Recipe
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                //MARK: - Ingredients
                
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                        .padding([.bottom, .top], 1)
                    
                    ForEach(recipe.ingredients, id: \.self) { item in
                        Text("• " + item)
                           // .padding(.bottom, 1)
                    }
                }
                .padding(.horizontal)
                Divider()
                    //MARK: - Directions
                    VStack (alignment: .leading) {
                        Text("Directions")
                            .font(.headline)
                            .padding([.bottom, .top], 2)
                        
                        ForEach(0..<recipe.directions.count, id: \.self) { index in
                            Text(String(index + 1) + ". " + recipe.directions[index])
                                .padding(.bottom, 1)
                                
                        }
                    }
                    .padding(.horizontal)
            }
            
        }.navigationBarTitle(recipe.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        //create a dummy ecipe and pass it into the detail view so we can see a preview
        let model = RecipeViewModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
