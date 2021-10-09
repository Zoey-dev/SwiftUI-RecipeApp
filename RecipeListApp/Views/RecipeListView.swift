//
//  ContentView.swift
//  RecipeListApp
//
//  Created by Princess  on 26/09/2021.
//

import SwiftUI

struct RecipeListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    //fetch data from core data
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    private var recipes : FetchedResults<Recipe>
    
    @State private var filters = ""
    //binding what the user types in to get the subdata of the recipes
    private var filteredRecipes: [Recipe] {
        if filters.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            //No filter result, return all recipes
            return Array(recipes)
        } else {
            //filter by search term
            return recipes.filter { r in
                return r.name.contains(filters)
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                Text("All Recipes")
                    .bold()
                    .padding(.top, 40)
                    .font(.title)
                    
                SearchBarView(filterBy: $filters)
                    .padding([.trailing, .bottom])
                
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(filteredRecipes) { r in
                            
                           NavigationLink(
                            destination: RecipeDetailView(recipe: r),
                            label: {
                                HStack(spacing: 15.0){
                                    //because we changed image type from string to Binary data, we will pass it in thus:
                                    let image = UIImage(data: r.image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFill()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .clipped()
                                    VStack(alignment: .leading) {
                                        Text(r.name)
                                            .foregroundColor(.black)
                                            .bold()
                                        RecipeHighlights(highlight: r.highlights)
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                            })
                           
                        }
                        
                        
                    }
                }
            }
            .navigationBarHidden(true)
            .padding(.leading)
            .onTapGesture {
                //Clear search bar when you tap outside
                let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView().previewDevice("iPhone 12")
            .environmentObject(RecipeViewModel())
    }
}
