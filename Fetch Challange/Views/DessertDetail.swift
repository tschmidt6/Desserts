//
//  DessertDetail.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/22/23.
//

import SwiftUI

struct DessertDetail: View {
    var dessert: Dessert
    
    var body: some View {
        VStack {
            Text(dessert.strMeal)
                .font(.title3)
                .bold()
        }
    }
}

struct DessertDetail_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetail(dessert: .preview)
    }
}
