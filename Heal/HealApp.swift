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
    // HK Authorize ini dibuat di sini buat environment object biar Instances nya dipake dimana2, nah ini dibuat dari akarnya aja
    let authorizer = HKAuthorize()
    let notification = NotificationHelper()

    var body: some Scene {
        WindowGroup {
            PreAlertView(notification: notification)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(authorizer)
        }
    }
}
