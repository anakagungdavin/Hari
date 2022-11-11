//
//  HealthHearthRate.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 11/11/22.
//

import Foundation
import HealthKit
import CoreData

struct HeartRateEntry: Hashable, Identifiable {
    var heartRate: Double
    var date: Date
    var id = UUID()
}

class HKHeartRate: ObservableObject {

//    var lastHeartRate = 0.0
    @Published var heartData: [HeartRateEntry] = []
    var queryAnchor: HKQueryAnchor?
    let heartRateQuantity = HKUnit(from: "count/min")

    func observeHeartRate() {

        startHeartRateQuery()
    }

    private func startHeartRateQuery() {
        guard let heartRate = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else {
            return
        }

        let queryHeartRate = HKAnchoredObjectQuery(type: heartRate,
                                                   predicate: nil,
                                                   anchor: queryAnchor,
                                                   limit: HKObjectQueryNoLimit,
                                                   resultsHandler: self.updateHandler)

        queryHeartRate.updateHandler = self.updateHandler(query:newSamples:deleteSamples:newAnchor:error:)
        HKAuthorize().healthStore?.execute(queryHeartRate)
    }

    func updateHandler(query: HKAnchoredObjectQuery,
                       newSamples: [HKSample]?,
                       deleteSamples: [HKDeletedObject]?,
                       newAnchor: HKQueryAnchor?,
                       error: Error?) {

        if let error = error {
            print("Health query error \(error)")
        } else {
            let unit = HKUnit(from: "count/min")
            if let newSamples = newSamples as? [HKQuantitySample], !newSamples.isEmpty {
                print("Received \(newSamples.count) new samples")
                DispatchQueue.main.async {

                    var currentData = self.heartData
                    currentData.append(contentsOf: newSamples.map {
                        HeartRateEntry(heartRate: $0.quantity.doubleValue(for: unit),
                                       date: $0.startDate)
                    })

                    self.heartData = currentData.sorted(by: { $0.date > $1.date })
                }
            }

            queryAnchor = newAnchor
        }
    }

//    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
//        for sample in samples {
//            if type == .heartRate {
//                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
//            }
//        }
//    }
}
