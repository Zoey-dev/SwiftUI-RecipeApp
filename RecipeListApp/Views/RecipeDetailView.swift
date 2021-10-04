//
//  RecipeDetailView.swift
//  RecipeListApp
//
//  Created by Princess  on 28/09/2021.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe:Recipe
    @State var selectServingSize = 2
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                //MARK: Image Section
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                //MARK: - Server Size Picker
                VStack(alignment: .leading) {
                    Text("Select your serving size:")
                        
                    Picker("", selection: $selectServingSize) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 170)
                    
                }.padding()
                
                //MARK: - Ingredients
                
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                        .padding([.bottom, .top], 1)
                    
                    ForEach(recipe.ingredients) { item in
                        Text("• " + RecipeViewModel.getServings(ingredient: item, recipeServings: recipe.servings, targetServings: selectServingSize) + " " + item.name.lowercased())
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
