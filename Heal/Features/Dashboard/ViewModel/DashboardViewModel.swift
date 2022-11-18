//
//  DashboardViewModel.swift
//  TesDashboard
//
//  Created by heri hermawan on 13/10/22.
//  swiftlint:disable force_try

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
    
    func getEcgThisMonth(ecg: FetchedResults<Ecg>) -> [Ecg] {
        let dateTemp = getStartEndDate()
        
        let ecgTemp = ecg.filter { data in
            data.timeStampECG! >= dateTemp.startDate! && data.timeStampECG! <= dateTemp.endDate!
        }
        
        return ecgTemp
    }
    
    func getJurnalCompleteCount(ecg: FetchedResults<Ecg>) -> Int{
        let dateTemp = getStartEndDate()
        
        let ecgTemp = ecg.filter { data in
            data.timeStampECG! >= dateTemp.startDate! && data.timeStampECG! <= dateTemp.endDate! &&
            data.activities != " "
        }
        
        return ecgTemp.count
    }
    
    func getJurnalIncompleteCount(ecg: FetchedResults<Ecg>) -> Int{
        let dateTemp = getStartEndDate()
        
        let ecgTemp = ecg.filter { data in
            data.timeStampECG! >= dateTemp.startDate! && data.timeStampECG! <= dateTemp.endDate! &&
            data.activities == " "
        }
        
        return ecgTemp.count
    }
    
    func getStartEndDate() -> (startDate: Date?, endDate: Date?){
        let selectedYear = Int(DateFormatter.displayYear.string(from: Calendar.current.date(byAdding: .day, value: 0, to: Date())!))
        let selectedMonth = Int(DateFormatter.displayMonthNumb.string(from: Calendar.current.date(byAdding: .day, value: 0, to: Date())!))
        
        var components = DateComponents()
        components.month = selectedMonth
        components.year = selectedYear
        let startDateOfMonth = Calendar.current.date(from: components)

        components.year = 0
        components.month = 1
        components.day = -1
        let endDateOfMonth = Calendar.current.date(byAdding: components, to: startDateOfMonth!)
        
        return (startDateOfMonth, endDateOfMonth)
    }
}
