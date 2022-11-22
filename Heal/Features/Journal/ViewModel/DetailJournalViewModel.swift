//
//  DetailJournalViewModel.swift
//  Heal
//
//  Created by Nur Mutmainnah Rahim on 15/11/22.
//  swiftlint:disable identifier_name
//  swiftlint:disable force_try

import SwiftUI
import CoreData

class DetailJournalViewModel: ObservableObject {
    @FetchRequest(entity: Ecg.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.avgBPM, ascending: true)])
    var Item: FetchedResults<Ecg>
    @Published var catatanku = ""
    @Published var konsumsiObat = ""
    @Published var aktivitasku = ""
    @Published var gejalaku:[String] = []
    @Published var updateItem : Ecg!
    
    func addItem(viewContext: NSManagedObjectContext) {
        if updateItem != nil {
            updateItem.notes = catatanku
            updateItem.obat = konsumsiObat
            updateItem.activities = aktivitasku
            updateItem.symptoms = gejalaku
            
            try! viewContext.save()
            updateItem = nil
            return
        }
        
        let newItem = Ecg(context: viewContext)
        newItem.notes = catatanku
        newItem.obat = konsumsiObat
        newItem.activities = aktivitasku
        newItem.symptoms = gejalaku
        
    }
    
    func editItem(item: Ecg?){
        updateItem = item
        guard let catatanTemp = item?.notes else { return }
        catatanku = catatanTemp
        guard let obatTemp = item?.obat else { return }
        konsumsiObat = obatTemp
        guard let aktTemp = item?.activities else {return}
        aktivitasku = aktTemp
        guard let symTemp = item?.symptoms else {return}
        gejalaku = symTemp
        print(konsumsiObat)
        
    }
}
