//
//  DessertDetail.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/22/23.
//

import SwiftUI

struct DessertDetail: View {
    var dessert: Dessert
    @State private var dessertProperties: DessertProperties? = nil
    
    @State private var dessertImage: Image? = Image(uiImage: UIImage(systemName: "rectangle")!) // placeholder
    @State private var error: NetworkError?
    @State private var hasError = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Image
                ZStack(alignment: .bottom) {
                    image
                    VStack {
                        HStack {
                            Text(dessert.strMeal)
                                .font(.title)
                            Spacer()
                        }
                        HStack {
                            Text(dessertProperties?.tags ?? "Tags")
                            Spacer()
                        }
                    }
                    .padding(20)
                    .foregroundStyle(.background.shadow(.drop(radius: 2)))
                    .background {
                        Color(.gray)
                            .opacity(0.8)
                            .shadow(radius: 4, y: -4)
                    }
                }
                // Ingredients & Measurements
                Ingredients(ingredients: dessertIngredients, measurements: dessertMeasurements)
                
                // Instructions
                Instructions(instructions: dessertInstructions)
            }
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            Task {
                await downloadDessertProperties()
                await downloadDessertImage()
            }
        }
        .alert(isPresented: $hasError, error: error) { }
    }
    
    var image: some View {
        dessertImage!
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 300)
            .clipped()
            .overlay {
                LinearGradient(
                    colors: [Color(.systemBackground), .clear, .clear],
                    startPoint: .top,
                    endPoint: .bottom)
            }
    }
    
    var dessertInstructions: String? {
        dessertProperties?.instructions
    }
    
    var dessertIngredients: [String]? {
        dessertProperties?.ingredients
    }
    
    var dessertMeasurements: [String]? {
        dessertProperties?.measurements
    }
}

extension DessertDetail {
    func downloadDessertProperties() async {
        do {
            let data = try await DessertClient.shared.downloadDessertProperties(idMeal: dessert.idMeal)
            if let dessertProperties = data {
                await MainActor.run {
                    self.dessertProperties = dessertProperties
                }
            }
        } catch {
            self.error = error as? NetworkError
            self.hasError = true
        }

    }
    
    func downloadDessertImage() async {
        let data = await ImageLoader.publicCache.loadAsync(url: URL(string: dessert.strMealThumb)! as NSURL)
        if let data = data {
            await MainActor.run {
                dessertImage = Image(uiImage: data)
            }
        }
    }
}

struct DessertDetail_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetail(dessert: .preview)
    }
}
