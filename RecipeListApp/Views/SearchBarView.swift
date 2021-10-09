//
//  SearchBarView.swift
//  RecipeListApp
//
//  Created by Princess  on 09/10/2021.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var filterBy: String
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 4)
            
            HStack{
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $filterBy)
                
                Button {
                    //clear the text field
                    filterBy = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                    
                }

            }.padding()
        }
        .frame(height: 40)
        .foregroundColor(.gray)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(filterBy: Binding.constant(""))
    }
}
