//
//  RecipeFeaturedView.swift
//  RecipeListApp
//
//  Created by Princess  on 29/09/2021.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeViewModel
    @State var showDetailedView = false
    @State var tabSelectionIndex = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 30)
                .font(.title)
                
            
        GeometryReader { geo in
            TabView(selection: $tabSelectionIndex) {
                //loop over the recipes
                ForEach(0..<model.recipes.count) { index in
                    
                    //if featured is true then create a rectangle for each
                    if model.recipes[index].featured {
                        
                        //recipe card
                        Button(action: {
                            self.showDetailedView = true
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                
                                VStack (spacing: 0) {
                                    Image(model.recipes[index].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(model.recipes[index].name)
                                        .padding(5)
                                }
                            }
                        })
                            .tag(index)
                        .sheet(isPresented: $showDetailedView) {
                            // show detailed view when true
                            RecipeDetailView(recipe: model.recipes[index])
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: geo.size.width - 40, height: geo.size.height - 100)
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                    }
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Preparation Time:")
                    .font(.headline)
                Text(model.recipes[tabSelectionIndex].prepTime)
                //Text("1 hour")
                Text("Highlights:")
                    .font(.headline)
                RecipeHighlights(highlight: model.recipes[tabSelectionIndex].highlights)
                //Text(model.recipes[tabSelectionIndex].[highlights])
               // Text("Healthy, Hearty")
            }.padding([.leading, .bottom])
            
        }
        .onAppear {
            featuredRecipe()
        }
    }
    
    func featuredRecipe() {
        
        let index = model.recipes.firstIndex { (recipe) -> Bool in
            return recipe.featured
        }
        tabSelectionIndex = index ?? 0
    }
    
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeViewModel())
    }
}
