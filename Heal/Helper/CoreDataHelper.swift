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
    var counter = Int()
    var avgBpms = [Double]()

    // var ecgSamples = [[(Double, Double)]]()

    // Diaturin buat ngehandle klo nilai parameternya kosong gimana (entah di sini atau di sana)
    func addItemECG(_ viewContext: NSManagedObjectContext,
                    _ resultDate: Date,
                    _ counter: Int,
                    _ bpmRate: Double,
                    _ symptoms: String = "",
                    _ notes: String = "",
                    _ activities: String = "",
                    _ xAxis: [Double],
                    _ yAxis: [Double]) {
        withAnimation {
            let newItem = Ecg(context: viewContext)
            newItem.timeStampECG = resultDate
            newItem.counter = Int32(counter)
            newItem.avgBPM = bpmRate
            newItem.symptoms = symptoms
            newItem.notes = notes
            newItem.activities = activities
            newItem.xAxis = xAxis
            newItem.yAxis = yAxis
            // newItem.voltageECG = resultSample

            do {
                try viewContext.save()
                print("***** TANGALAN \(String(describing: newItem.timeStampECG))")
                print("** DEBUG COUNT NEW ITEM YAXIS \(String(describing: newItem.yAxis?.count))")
                print("** DEBUG COUNT NEW ITEM YAXIS \(String(describing: newItem.yAxis?.count))")
                // self.ecgDates = [Date]()
                // self.counter = Int()
                // self.avgBpms = [Double]()
                // self.ecgSamples = [[(Double, Double)]]()
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

    // Diaturin buat ngehandle klo nilai parameternya kosong gimana (entah di sini atau di sana)
    func addIaddtemProfile(_ viewContext: NSManagedObjectContext,
                           _ name: String,
                           _ age: Int32,
                           _ doBirth: Date,
                           _ weight: Int32,
                           _ height: Int32,
                           _ sex: String,
                           _ commorbit: String) {

        let newItem = Profile(context: viewContext)
        newItem.name = name
        newItem.age = age
        newItem.doBirth = doBirth
        newItem.weight = weight
        newItem.height = height
        newItem.sex = sex
        newItem.commorbit = commorbit

        do {
            try viewContext.save()

        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate.
            // You should not use this function in a shipping application,
            // although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func updateItem(profile: Profile) {

        let newName = profile.name
        let newAge = profile.age
        let newdOBirth = profile.doBirth
        let newWeight = profile.weight
        let newHeight = profile.height
        let newGender = profile.sex
        let newCommorbit = profile.commorbit

        viewContext.performAndWait {
            profile.name = newName
            profile.age = newAge
            profile.doBirth = newdOBirth
            profile.weight = newWeight
            profile.height = newHeight
            profile.sex = newGender
            profile.commorbit = newCommorbit

            try? viewContext.save()
        }
    }

    func updateECG(ecg: Ecg) {
        
        let newSymptoms = ecg.symptoms
        
        viewContext.performAndWait {
            ecg.symptoms = newSymptoms
            try? viewContext.save()


        }
    }
}
