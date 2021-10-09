//
//  RecipeFeaturedView.swift
//  RecipeListApp
//
//  Created by Princess  on 29/09/2021.
//

import SwiftUI

struct RecipeFeaturedView: View {
    @State var showDetailedView = false
    @State var tabSelectionIndex = 0
    
    //use a fetchRequest to look into our core data database amd fetch all the recipes
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate: NSPredicate(format: "featured == true"))
    var recipes: FetchedResults<Recipe>
    
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
                    ForEach(0..<recipes.count) { index in
                        
                        //recipe card
                        Button(action: {
                            self.showDetailedView = true
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                
                                VStack (spacing: 0) {
                                    let image = UIImage(data: recipes[index].image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(recipes[index].name)
                                        .padding(5)
                                }
                            }
                        })
                            .tag(index)
                            .sheet(isPresented: $showDetailedView) {
                                // show detailed view when true
                                RecipeDetailView(recipe: recipes[index])
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100)
                            .cornerRadius(15)
                            .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                        
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Preparation Time:")
                    .font(.headline)
                Text(recipes[tabSelectionIndex].prepTime)
                //Text("1 hour")
                Text("Highlights:")
                    .font(.headline)
                RecipeHighlights(highlight: recipes[tabSelectionIndex].highlights)
                //Text(model.recipes[tabSelectionIndex].[highlights])
                // Text("Healthy, Hearty")
            }.padding([.leading, .bottom])
            
        }
        .onAppear {
            featuredRecipe()
        }
    }
    
    func featuredRecipe() {
        
        let index = recipes.firstIndex { (recipe) -> Bool in
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
