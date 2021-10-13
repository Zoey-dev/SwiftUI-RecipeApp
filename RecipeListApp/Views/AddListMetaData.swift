//
//  AddListMetaData.swift
//  RecipeListApp
//
//  Created by Princess  on 11/10/2021.
//

import SwiftUI

struct AddListMetaData: View {
    
    @Binding var list: [String]
    @State private var item: String = ""
    var title: String
    var placeholder: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("\(title): ")
                    .bold()
                    //.foregroundColor(.white)
                TextField(placeholder, text: $item)
                
                Button("Add") {
                    //add item to the list
                    if item.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        list.append(item.trimmingCharacters(in: .whitespacesAndNewlines))
                        //clear after adding
                        item = ""
                    }
                }.foregroundColor(.black)
            }
            
            ForEach(list, id: \.self) { item in
                Text(item)
            }
        }
    }
}

//struct AddListMetaData_Previews: PreviewProvider {
//    static var previews: some View {
//        AddListMetaData(list: )
//    }
//}
