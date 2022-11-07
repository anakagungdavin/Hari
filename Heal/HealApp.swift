//
//  HealApp.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 27/09/22.
//

import SwiftUI

@main
struct HealApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            JournalView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
