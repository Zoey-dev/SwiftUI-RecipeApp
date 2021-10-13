//
//  Recipe.swift
//  RecipeListApp
//
//  Created by Princess  on 26/09/2021.
//

import Foundation


class RecipeJSON: Identifiable, Decodable {
    
    var id: UUID?
    var name: String
    var featured: Bool
    var image: String
    var description: String
    var prepTime: String
    var cookTime: String
    var totalTime: String
    var servings: Int
    var highlights: [String]
    var ingredients: [IngredientsJSON]
    var directions: [String]
    
    
}

class IngredientsJSON: Identifiable, Decodable {
    
    var id: UUID?
    var name: String = ""
    var num: Int?
    var denom: Int?
    var unit: String?
}
