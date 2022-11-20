//
//  HealthHearthRate.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 11/11/22.
//

import Foundation
import HealthKit
import CoreData
import UserNotifications

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
        readIrregular()
    }

    private func startHeartRateQuery() {
        guard let heartRate = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else {
            return
        }

        let queryHeartRate = HKAnchoredObjectQuery(type: heartRate,
                                                   predicate: nil,
                                                   anchor: queryAnchor,
                                                   limit: HKObjectQueryNoLimit,
                                                   resultsHandler: self.updateHandlerHR)

        queryHeartRate.updateHandler = self.updateHandlerHR(query:newSamples:deleteSamples:newAnchor:error:)
        HKAuthorize().healthStore?.execute(queryHeartRate)
    }

    func updateHandlerHR(query: HKAnchoredObjectQuery, newSamples: [HKSample]?, deleteSamples: [HKDeletedObject]?, newAnchor: HKQueryAnchor?, error: Error?) {

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

    func readIrregular() {

        let irregularType = HKCategoryType(HKCategoryTypeIdentifier.irregularHeartRhythmEvent)
        let queryIrreg: HKObserverQuery = HKObserverQuery(sampleType: irregularType,
                                                          predicate: nil,
                                                          updateHandler: self.irregularHandler)

        HKAuthorize().healthStore?.execute(queryIrreg)
        HKAuthorize().healthStore?.enableBackgroundDelivery(for: irregularType,
                                                            frequency: .immediate,
                                                            withCompletion: { success, error in
            if !success {
                print(String(describing: error))
            }
        })

    }

    // Still buggy need to fix
    func irregularHandler(query: HKObserverQuery!, completionHandler: HKObserverQueryCompletionHandler!, error: Error!) {

        print("New Data")

//        let content = UNMutableNotificationContent()
//        content.title = "Irregular rhythm"
//        content.body = "Notification triggered"
//        content.subtitle = "Please do your ECG"
//        content.sound = UNNotificationSound.default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request)

        completionHandler()
    }
}
