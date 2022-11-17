//
//  DetailJournalViewModel.swift
//  Heal
//
//  Created by Nur Mutmainnah Rahim on 15/11/22.
//

import SwiftUI
import CoreData

class DetailJournalViewModel: ObservableObject {
    @FetchRequest(entity: Ecg.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.avgBPM, ascending: true)])
    var Item: FetchedResults<Ecg>
    @Published var catatanku = ""
    @Published var updateItem : Ecg!
    
    func addItem(viewContext: NSManagedObjectContext) {
        if updateItem != nil {
            updateItem.notes = catatanku
            
            try! viewContext.save()
            updateItem = nil
            return
        }
        
        let newItem = Ecg(context: viewContext)
        newItem.notes = catatanku
    }
}
