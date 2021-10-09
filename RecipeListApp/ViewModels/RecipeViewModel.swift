//
//  RecipeViewModel.swift
//  RecipeListApp
//
//  Created by Princess  on 26/09/2021.
//

import Foundation
import SwiftUI

class RecipeViewModel: ObservableObject {
    //reference to managed object context
    let managedDataContext = PersistenceController.shared.container.viewContext
    
    @Published var recipes = [Recipe]()
    
    init() {
        //check if we have preloaded the data
        checkLoadedData()
    }
    
    func checkLoadedData () {
        //check local storage for a flag
        let status = UserDefaults.standard.bool(forKey: K.isDataPreloaded)
        
        //if it's false, parse the local JSON then preload local data into core data
        if status == false {
            preloadLocalData()
        }
        
    }
    
    func preloadLocalData () {
        
        //parse the local JSON file
       let localRecipes = DataService.getLocalData()
        
        //create core data objects
        for r in localRecipes {
            //create a core data object
           let recipe = Recipe(context: managedDataContext)
            //set it's properties
            recipe.directions = r.directions
            recipe.featured = r.featured
            recipe.prepTime = r.prepTime
            recipe.servings = r.servings
            recipe.name = r.name
            recipe.highlights = r.highlights
            recipe.id = UUID()
            recipe.image = UIImage(named: r.image)?.jpegData(compressionQuality: 1.0)
            recipe.summary = r.description
            recipe.totalTime = r.totalTime
            
            //set the ingredients
            for i in r.ingredients {
                
                //create a core data ingredient
                let ingredient = Ingredient(context: managedDataContext)
                //set the properties
                ingredient.id = UUID()
                ingredient.name = i.name
                ingredient.unit = i.unit
                ingredient.denom = i.denom ?? 1
                ingredient.num = i.num ?? 1
                
                
                //add ingredient to the recipe
                recipe.addToIngredients(ingredient)
            }
            
        }
        
        //save into core data
        do {
            try  managedDataContext.save()
            //set local storage file if it successfully saves
            UserDefaults.standard.setValue(true, forKey: K.isDataPreloaded)
        } catch {
            //couldn't save the data
            print(error)
        }
       
        
        
        
    }
    
    
    static func getServings(ingredient: Ingredient, recipeServings: Int, targetServings: Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num
        var denominator = ingredient.denom
        var wholeportions = 0
        
        //if ingredient.num != nil {
            //get a single serving size by multiplying the denominator by the recipe serving
            
            denominator *= recipeServings
            
            //get the target portion by multiplying numverator by target servings
            numerator *= targetServings
            
            //reduce fractio by greatest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            //get the whole portion if numerator > denominator
        
            if numerator >= denominator {
                //calculate whole portions
                wholeportions = numerator / denominator
                
                //czlculate the remainder
                numerator = numerator % denominator
                
                //assign to portion string
                portion += String(wholeportions)
            }
            
            //express denominator as a fraction
            if numerator > 0 {
                
                portion += wholeportions > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
            }
       // }
            
            if let unit = ingredient.unit {
                
                portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
                return portion + unit
            }
        
        
        return portion
    }
}













