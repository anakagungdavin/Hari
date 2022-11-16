//
//  DashboardViewModel.swift
//  TesDashboard
//
//  Created by heri hermawan on 13/10/22.
//

import SwiftUI
import CoreData

class DashboardViewModel: ObservableObject {
    @Published var ecg = ""
    @Published var activity = ""
    
    @Published var updateItem : Ecg!
    
    func addItem(viewContext: NSManagedObjectContext) {
        withAnimation {
            if updateItem != nil {
                updateItem.activities = ecg
                updateItem.activities = activity
                
                try! viewContext.save()
                updateItem = nil
                return
            }
            
            let newItem = Ecg(context: viewContext)
            newItem.timeStampECG = Date()
            newItem.activities = ecg
            newItem.activities = activity

            do {
                try viewContext.save()
//                isNewData.toggle()
                ecg = ""
                activity = ""
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func editItem(item: Ecg?){
        updateItem = item
        guard let ecgTemp = item?.activities else { return }
        ecg = ecgTemp
        guard let activityTemp = item?.activities else { return }
        activity = activityTemp
    }
}
