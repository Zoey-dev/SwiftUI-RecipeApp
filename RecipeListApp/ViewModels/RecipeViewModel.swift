//
//  RecipeViewModel.swift
//  RecipeListApp
//
//  Created by Princess  on 26/09/2021.
//

import Foundation

class RecipeViewModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        // because the getLocalData function is a static func, we don't need to create an instance of it
        self.recipes = DataService.getLocalData()
    }
    
    
    static func getServings(ingredient: Ingredients, recipeServings: Int, targetServings: Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholeportions = 0
        
        if ingredient.num != nil {
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
        }
            
            if let unit = ingredient.unit {
                
                portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
                return portion + unit
            }
        
        
        return portion
    }
}













