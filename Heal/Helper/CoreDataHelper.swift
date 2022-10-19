//
//  CoreDataHelper.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 19/10/22.
//

import Foundation
import CoreData
import SwiftUI

class CoreHelper {

    @Environment(\.managedObjectContext) private var viewContext
    var ecgDates = [Date]()

    func addItem(_ viewContext : NSManagedObjectContext, _ hasil : Date) {
        withAnimation {
            let newItem = Ecg(context: viewContext)
            newItem.timeStampECG = hasil

            do {
                try viewContext.save()
                self.ecgDates = [Date]()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}
