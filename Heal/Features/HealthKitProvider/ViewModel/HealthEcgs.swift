//
//  HealthStore.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 10/10/22.
//  swiftlint:disable unused_closure_parameter
//  swiftlint:disable force_cast
//  swiftlint:disable identifier_name

import Foundation
import HealthKit
import SwiftUI
import CoreData

class HKEcgs: ObservableObject {

    @Published var ecgDates = [Date]()
    @Published var indices = [(Int, Int)]()
    @Published var avgBpms = [Double]()

    var healthStore = HKHealthStore()
    var ecgSamples = [[(Double, Double)]]()
    var xAxis = [Double]()
    var yAxis = [Double]()

    func getECGs(counter: Int, completion: @escaping (Double, [(Double, Double)], Date) -> Void) {

        var ecgSamples = [(Double, Double)]()
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                    end: Date.distantFuture,
                                                    options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)

        let ecgQuery = HKSampleQuery(sampleType: HKObjectType.electrocardiogramType(),
                                     predicate: predicate,
                                     limit: HKObjectQueryNoLimit,
                                     sortDescriptors: [sortDescriptor]) { (query, samples, error) in guard
                                        let samples = samples,
                                            let mostRecentSample = samples.first as? HKElectrocardiogram else {

                return
            }
            print("******** Recent \(mostRecentSample)")

            let electroCardiogram = samples[counter] as! HKElectrocardiogram
            let query = HKElectrocardiogramQuery(electroCardiogram) { [self] (query, result) in

                switch result {
                case .error(let error):
                    print("error: ", error)

                case .measurement(let value):
                    let sample = (value.quantity(for: .appleWatchSimilarToLeadI)!.doubleValue(for: HKUnit.volt()),
                                  value.timeSinceSampleStart)
                    ecgSamples.append(sample)

                case .done:
                    let averageBPM = electroCardiogram.averageHeartRate?.doubleValue(for: HKUnit.count().unitDivided(by: .minute())) ?? 0
                    // print("done")

                    DispatchQueue.main.async {
                        completion(averageBPM, ecgSamples, samples[counter].startDate)
                    }
                @unknown default:
                    return
                }
            }
            self.healthStore.execute(query)
        }


        self.healthStore.execute(ecgQuery)
        // print("everything working here")
        print(ecgSamples.count)
        return

    }

    func getECGsCount(completion: @escaping (Int) -> Void) {
        var result: Int = 0
        let ecgQuery = HKSampleQuery(sampleType: HKObjectType.electrocardiogramType(),
                                     predicate: nil,
                                     limit: HKObjectQueryNoLimit,
                                     sortDescriptors: nil) {(query, samples, error) in
            guard let samples = samples
            else {
                return
            }
            result = samples.count
            completion(result)
        }
        self.healthStore.execute(ecgQuery)
    }

    func readECGs(_ viewContext: NSManagedObjectContext){
        var counter = 0

        self.getECGsCount { (ecgsCount) in
            print("Result is \(ecgsCount)")
            if ecgsCount < 1 {
                print("You have no ecgs available")
                return
            } else {
                for i in 0...ecgsCount - 1 {
                    self.getECGs(counter: i) { (ecgBPM, ecgResults, ecgDate)  in
                        DispatchQueue.main.async {
                            self.ecgSamples.append(ecgResults)
                            self.ecgDates.append(ecgDate)
                            for j in 0...ecgResults.count - 1 {
                                self.yAxis.append(ecgResults[j].0)
                                self.xAxis.append(ecgResults[j].1)
                            }
                            CoreHelper().addItemECG(viewContext,
                                                    ecgDate,
                                                    counter,
                                                    ecgBPM,
                                                    " ",
                                                    " ",
                                                    " ",
                                                    self.xAxis,
                                                    self.yAxis)
                            self.avgBpms.append(ecgBPM)
                            counter += 1
                            print("************ \(ecgBPM)")
                            print("************ \(ecgDate)")
//                            print("\()")
                            print("****AAAAA \(ecgResults.count)")
                            print("****** \(ecgResults[0].0)")

//                            // the last thread will enter here, meaning all of them are finished
//                            if counter == ecgsCount {
//
//                                // sort ecgs by newest to oldest
//
//                                var newDates = self.ecgDates
//                                newDates.sort { $0 > $1 }
//                                for element in newDates {
//                                    self.indices.append((self.ecgDates.firstIndex(of: element)!,
                            // newDates.firstIndex(of: element)!))
//                                }
//
//                                self.ecgDates = newDates
//
//                                // indices matrix is a tuple matrix with two categories
//                                // the first is the sorted indice, and the second is the raw
//                                // ecgSamples[indices[0].0] is the newest ecg
//                            }
                        }
                    }
                }
            }
        }
    }
}
