//
//  AddRecipeView.swift
//  RecipeListApp
//
//  Created by Princess  on 10/10/2021.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    //properties for recipe meta data
    @State private var name = ""
    @State private var summary = ""
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var totalTime = ""
    @State private var servings = ""
    
    // list type recipe meta data
    @State private var highlights = [String]()
    @State private var directions = [String]()
    
    //ingredient meta data
    @State private var ingredients = [IngredientsJSON]()
    
    //image picker
    @State private var recipeImage: UIImage?
    
    @State private var isShowingImagePicker = false
    @State var selectedImagePicker = UIImagePickerController.SourceType.photoLibrary
    

    @State private var placeholderImage = Image("photo")
    
    var body: some View {
        ZStack {
            
            VStack {
                //Hstack with form controls
                HStack {
                    Button("Clear") {
                        //clear the form
                        clear()
                    }.padding()
                        .foregroundColor(.black)
                    Spacer()
                    
                    Button("Add") {
                        //add the recipe to core data
                        addRecipe()
                        //clear the form
                        clear()
                        
                    }.padding()
                        .foregroundColor(.black)
                    
                }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        //Recipe view
                        placeholderImage
                            .resizable()
                            .scaledToFit()
                        //.aspectRatio(contentMode: .fill)
                        
                        HStack {
                            Button("Photo Library") {
                                //when this button is tapped, the imagepicker should change to true
                                selectedImagePicker = .photoLibrary
                                isShowingImagePicker = true
                            }.foregroundColor(.black)
                            Text(" | ")
                            
                            Button("Camera") {
                                //when this button is tapped, the imagepicker shoukd change to true
                                selectedImagePicker = .camera
                                isShowingImagePicker = true
                            }.foregroundColor(.black)
                        }.sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                            ImagePicker(recipeImage: $recipeImage, selectedSource: selectedImagePicker)
                        }
                        
                        
                        AddMetaData(name: $name, summary: $summary, prepTime: $prepTime, cookTime: $cookTime, totalTime: $totalTime, servings: $servings)
                        
                        
                        AddListMetaData(list: $highlights, title: "Highlights", placeholder: "add highlights")
                        AddListMetaData(list: $directions, title: "Directions", placeholder: "add directions")
                        
                        AddIngredientData(ingredient: $ingredients)
                    }
                    .padding(.horizontal)
                }
                
            }
        }
        
    }
    
    
    func loadImage() {
        //
        if recipeImage != nil {
            placeholderImage = Image(uiImage: recipeImage!)
        }
    }
    
    func clear() {
        //clear form fields
        name = ""
        summary = ""
        prepTime = ""
        cookTime = ""
        totalTime = ""
        servings = ""
        
        highlights = [String]()
        directions = [String]()
        
        ingredients = [IngredientsJSON]()
        
        placeholderImage = Image("photo")
        
    }
    
    func addRecipe() {
        //add recipe to coredata
        let recipe = Recipe(context: viewContext)
        recipe.id = UUID()
        recipe.name = name
        recipe.summary = summary
        recipe.prepTime = prepTime
        recipe.cookTime = cookTime
        recipe.totalTime = totalTime
        recipe.servings = Int(servings) ?? 1
        recipe.highlights = highlights
        recipe.directions = directions
        recipe.image = recipeImage?.pngData()
        
        //add the ingredients
        for i in ingredients {
            let ingredient = Ingredient(context: viewContext)
            ingredient.id = UUID()
            ingredient.name = i.name
            ingredient.num = i.num ?? 1
            ingredient.denom = i.denom ?? 1
            ingredient.unit = i.unit
            
            //add this ingredient to the recipe
            recipe.addToIngredients(ingredient)
        }
        
        //save to core data
        do {
            try viewContext.save()
        } catch  {
            //couldn't save to core data
        }
        
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
