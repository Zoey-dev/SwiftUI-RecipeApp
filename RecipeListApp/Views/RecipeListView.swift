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
            
            VStack(alignment: .leading) {
                Text("All Recipes")
                    .bold()
                    .padding(.top, 30)
                    .font(.title)
                    
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(model.recipes) { r in
                            
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
                                        .foregroundColor(.black)
                                }
                            })
                           
                        }
                        .navigationBarHidden(true)
                        
                    }
                }
            }.padding(.leading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView().previewDevice("iPhone 12")
            .environmentObject(RecipeViewModel())
    }
}
