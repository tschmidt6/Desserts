//
//  DessertList.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/22/23.
//

import SwiftUI

struct DessertList: View {
    var dessertsProvider: DessertProvider = .shared
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.strMeal, order: .forward)])
    private var desserts: FetchedResults<Dessert>
    
    @State private var isLoading = false
    @State private var error: DessertError?
    @State private var hasError = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(desserts, id: \.idMeal) { dessert in
                    NavigationLink(destination: DessertDetail(dessert: dessert)) {
                        DessertRow(dessert: dessert)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Desserts")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        Task {
                            await fetchDesserts()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .disabled(isLoading)

                    Spacer()
                    VStack {
                        if isLoading {
                            Text("Loading Desserts...")
                            Spacer()
                        } else {
                            Text("\(desserts.count) Desserts")
                        }
                    }
                    Spacer()
                }
            }
            EmptyView()
        }
        .onAppear {
            
        }
        .alert(isPresented: $hasError, error: error) { }
    }
}

extension DessertList {
    private func fetchDesserts() async {
        isLoading = true
        do {
            try await dessertsProvider.fetchDesserts()
        } catch {
            self.error = error as? DessertError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
}

struct DessertList_Previews: PreviewProvider {
    static var previews: some View {
        DessertList()
    }
}
