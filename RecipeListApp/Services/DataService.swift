//
//  DataService.swift
//  RecipeListApp
//
//  Created by Princess  on 26/09/2021.
//

import Foundation


class DataService {
   //using static keyword turns this function to a type method that allows us call the method on the datatype without creating an instace of it, check the modelview
    static func getLocalData() -> [RecipeJSON] {
        
         //create a file path to where the json data is withon the bundle
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")

        //create a url object
        if let path = pathString {
            let url = URL(fileURLWithPath: path)

            //create a data object
            do {
                let data = try Data(contentsOf: url)

                //decode the data received with a JSON decoder
                let decoder = JSONDecoder()
                do {
                    let recipeData = try decoder.decode([RecipeJSON].self, from: data)

                    //add the unique ids to both recipe and ingredients
                    for recipe in recipeData {
                        recipe.id = UUID()

                        for ingredient in recipe.ingredients {
                            ingredient.id = UUID()
                        }
                    }

                    return recipeData

                } catch  {
                    //couldn't decode JSON
                    print(error)
                }

            } catch  {
                //error with getting data
                print(error)
            }


        }

        return [RecipeJSON]()
   }
    
}
