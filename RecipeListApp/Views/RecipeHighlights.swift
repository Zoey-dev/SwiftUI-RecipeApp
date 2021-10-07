//
//  RecipeHighlights.swift
//  RecipeListApp
//
//  Created by Princess  on 07/10/2021.
//

import SwiftUI

struct RecipeHighlights: View {
    
    var showHighlights = ""
    
    init(highlight: [String]) {
        
        for index in 0..<highlight.count {
            if index == highlight.count - 1 {
                showHighlights += highlight[index]
            } else {
                showHighlights += highlight[index] + ", "
            }
        }
    }
    
    var body: some View {
        
        Text(showHighlights)
    }
}

struct RecipeHighlights_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHighlights(highlight: ["text1", "text2", "text3"])
    }
}
