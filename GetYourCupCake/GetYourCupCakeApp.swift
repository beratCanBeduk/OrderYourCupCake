//
//  GetYourCupCakeApp.swift
//  GetYourCupCake
//
//  Created by berat can beduk on 6.12.2022.
//

import SwiftUI

@main
struct GetYourCupCakeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CupCakeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
