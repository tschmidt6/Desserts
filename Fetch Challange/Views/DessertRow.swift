//
//  DessertRow.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/22/23.
//

import SwiftUI

struct DessertRow: View {
    var dessert: Dessert
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dessert.strMeal)
                    .font(.title3)
            }
        }
        .padding(.vertical, 8)
    }
}

struct DessertRow_Previews: PreviewProvider {
    static var previews: some View {
        DessertRow(dessert: .preview)
    }
}
