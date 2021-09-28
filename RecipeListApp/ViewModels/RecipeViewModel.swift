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
}


//we would do this if we didn't make the getlocalData function a static function
//let service = DataService()
//self.recipes = service.getLocalData()
