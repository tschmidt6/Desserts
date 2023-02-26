//
//  Ingredients.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/25/23.
//

import SwiftUI

struct Ingredients: View {
    var ingredients: [String]? = []
    var measurements: [String]? = []
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                carrot
                Spacer()
                VStack {
                    // Grid
                    Grid(alignment: .top) {
                        GridRow {
                            Text("Ingredients")
                            Text("Measurements")
                        }
                        .font(.headline)
                        .fontWeight(.medium)
                        .padding(.bottom, 6)
                        .textCase(.uppercase)
                        // Other Rows
                        if ingredients != nil && measurements != nil {
                            ForEach(0..<ingredients!.count, id: \.self) { index in
                                GridRow {
                                    Text(ingredients![index]).gridColumnAlignment(.trailing)
                                    Text(measurements![index]).gridColumnAlignment(.leading)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }.padding(.bottom, 4)
        }.padding()
    }
    
    var carrot: some View {
        VStack {
            Image(systemName: "carrot")
                .rotationEffect(.degrees(-45))
                .font(.title)
            Spacer(minLength: 24)
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .frame(maxWidth: 2, maxHeight: .infinity)
        }
    }
}

struct Ingredients_Previews: PreviewProvider {
    static var previews: some View {
        Ingredients()
    }
}
