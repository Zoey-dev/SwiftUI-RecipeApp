//
//  AddIngredientData.swift
//  RecipeListApp
//
//  Created by Princess  on 11/10/2021.
//

import SwiftUI

struct AddIngredientData: View {
    
    @Binding var ingredient: [IngredientsJSON]
    @State private var name = ""
    @State private var num = ""
    @State private var denom = ""
    @State private var unit = ""
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients: ")
                .bold()
                .padding(.top, 5)
                //.foregroundColor(.white)
            
            HStack{
                
                TextField("Ingredient", text: $name)
                    
                TextField("1", text: $num)
                    .frame(width: 20)
                Text("/")
                TextField("1", text: $denom)
                    .frame(width: 20)
                TextField("unit", text: $unit)
                
                Button("Add") {
                    //make sure the fields are populated
                    let cleanedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedNum = num.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedDenom = denom.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedUnit = unit.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if cleanedName == "" || cleanedNum == "" || cleanedDenom == "" || cleanedUnit == "" {
                        return
                    }
                    
                    //create an ingredientJSON object and set its properties
                    let i = IngredientsJSON()
                    i.id = UUID()
                    i.name = cleanedName
                    i.num = Int(cleanedNum) ?? 1
                    i.denom = Int(cleanedDenom) ?? 1
                    i.unit = cleanedUnit
                    
                    //add the ingredients
                    ingredient.append(i)
                    
                    //clear textfields
                    name = ""
                    num = ""
                    denom = ""
                    unit = ""
                }
                .foregroundColor(.black)
            }
            
            ForEach(ingredient) { ingredient in
                Text("\(ingredient.name), \(ingredient.num ?? 1)/\(ingredient.denom ?? 1) \(ingredient.unit ?? "")")
            }
        }
    }
}



//struct AddIngredientData_Previews: PreviewProvider {
//    static var previews: some View {
//        AddIngredientData()
//    }
//}
