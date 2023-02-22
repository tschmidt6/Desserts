//
//  Fetch_ChallangeApp.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/22/23.
//

import SwiftUI

@main
struct Fetch_ChallangeApp: App {
    var body: some Scene {
        WindowGroup {
            DessertList()
                .environment(\.managedObjectContext, DessertProvider.shared.container.viewContext)
        }
    }
}
