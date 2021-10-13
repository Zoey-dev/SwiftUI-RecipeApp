//
//  AddMetaData.swift
//  RecipeListApp
//
//  Created by Princess  on 10/10/2021.
//

import SwiftUI

struct AddMetaData: View {
    //properties for recipe meta data
    @Binding var name: String
    @Binding var summary: String
    @Binding var prepTime: String
    @Binding var cookTime: String
    @Binding var totalTime: String
    @Binding var servings: String
    
    // list type recipe meta data

    
    var body: some View {
        Group {
            HStack {
                Text("Name: ")
                    .bold()
                    //.foregroundColor(.white)
                TextField("Tuna Casserole", text: $name)
            }
          
            HStack {
                Text("Summary: ")
                    .bold()
                    //.foregroundColor(.white)
                TextField("add summary", text: $summary)
                    //.foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1.00))
            }
            HStack {
                Text("Prep Time: ")
                    .bold()
                   // .foregroundColor(.white)
                TextField("add prep time", text: $prepTime)
                    //.foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1.00))
            }
            HStack {
                Text("Cook Time: ")
                    .bold()
                    //.foregroundColor(.white)
                TextField("add cook time", text: $cookTime)
                   // .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1.00))
            }
            HStack {
                Text("Total Time: ")
                    .bold()
                    //.foregroundColor(.white)
                TextField("add total time", text: $totalTime)
                   // .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1.00))
            }
            HStack {
                Text("Servings: ")
                    .bold()
                    // .foregroundColor(.white)
                TextField("add servings", text: $servings)
                   // .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1.00))
            }
        }
    }
}

//struct AddMetaData_Previews: PreviewProvider {
//    static var previews: some View {
//        AddMetaData()
//    }
//}
