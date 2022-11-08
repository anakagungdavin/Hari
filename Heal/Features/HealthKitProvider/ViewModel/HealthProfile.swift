//
//  HealthProfile.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 18/10/22.
//

import Foundation
import HealthKit

class HKProfile: ObservableObject {

//    var healthStore = HKHealthStore()
    var height = Int32()
    var weight = Int32()
    var sexs = String()
    var dob = Date()
    var anchor = HKQueryAnchor.init(fromValue: 0)
    var userDefault = UserDefaults.standard

    // most likely interchangable data
    func readData(completion: @escaping(Bool, Error?) -> Void) {
            var age: Int?
            var sex: HKBiologicalSex?
            var sexData: String = "Not Retrived"

            do {
                let birthDay = try HKAuthorize().healthStore?.dateOfBirthComponents()
                let calendar = Calendar.current
                let currentYear = calendar.component(.year, from: Date() )
                age = currentYear - (birthDay?.year! ?? 0)
                guard let dob = birthDay?.date else {
                    return
                }
            } catch {}

            do {
                let getSex = try HKAuthorize().healthStore?.biologicalSex()
                sex = getSex?.biologicalSex
                if let data = sex {
                    sexData = self.getReadableBiologicalSex(biologicalSex: data)
                    sexs = sexData
                }
            } catch {}

            print("Age: \(age ?? 0)")
            print("Sex: \(sexData)")
    }

    func getReadableBiologicalSex(biologicalSex: HKBiologicalSex?) -> String {
        var biologicalSexTest = "Not Retrived"

        if biologicalSex != nil {
            switch biologicalSex!.rawValue {
            case 0:
                biologicalSexTest = ""
            case 1:
                biologicalSexTest = "Female"
            case 2:
                biologicalSexTest = "Male"
            case 3:
                biologicalSexTest = "Other"
            default:
                biologicalSexTest = ""
            }
        }

        return biologicalSexTest
    }

    // data that always updated
    func readRecentData(completion: @escaping(Bool, Error?) -> Void) {
        let irregularType = HKCategoryType(HKCategoryTypeIdentifier.irregularHeartRhythmEvent)
        let weightType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let heightType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!

//        var anchor = getAnchor()

        let queryWeigthnew = HKAnchoredObjectQuery(type: weightType,
                                                   predicate: nil,
                                                   anchor: anchor,
                                                   limit: HKObjectQueryNoLimit) { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in

            guard let samples = samplesOrNil,
                  let deletedObjects = deletedObjectsOrNil else {
                fatalError("*** An error occurred during the initial query: \(errorOrNil!.localizedDescription) ***")
            }

            guard let anchor = newAnchor else {
                return
            }

            self.setAnchor(queryAnchor: newAnchor)

            for bodyMassSample in samples {
                print("Samples: \(bodyMassSample)")
            }

            if let bodyMassSample = samples.last as? HKQuantitySample {
                self.weight = Int32(Int(bodyMassSample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))))
            }

            for deletedBodyMassSample in deletedObjects {
                print("Deleted: \(deletedBodyMassSample)")
            }

            print("Anchor: \(self.anchor)")
        }

        queryWeigthnew.updateHandler = { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
            guard let samples = samplesOrNil, let deletedObjects = deletedObjectsOrNil else {
                // Handle the error here.
                fatalError("*** An error occurred during an update: \(errorOrNil!.localizedDescription) ***")
            }

            if let bodyMassSample = samples.last as? HKQuantitySample {
                self.weight = Int32(Int(bodyMassSample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))))
            }

            self.anchor = newAnchor!
            self.setAnchor(queryAnchor: newAnchor)

            for bodyMassSample in samples {
                print("samples: \(bodyMassSample)")

            }

//            if let bodyMassSample = samples.last as? HKQuantitySample {
//                self.weight = Int32(Int(bodyMassSample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))))
//            }

            for deletedBodyMassSample in deletedObjects {
                print("deleted: \(deletedBodyMassSample)")
            }
        }

//        let queryWeight = HKSampleQuery(sampleType: weightType,
//                                        predicate: nil,
//                                        limit: HKObjectQueryNoLimit,
//                                        sortDescriptors: nil) { (query, results, error) in
//
//            if let result = results?.last as? HKQuantitySample {
//                print("weight => \(result.quantity)")
//                self.weight = Int32(Int(result.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))))
//            }
//        }

        let queryHeight = HKSampleQuery(sampleType: heightType,
                                        predicate: nil,
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: nil) { (query, results, error) in

            if let result = results?.last as? HKQuantitySample {
                print("height => \(result.quantity)")
                self.height = Int32(Int(result.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))))
            }
        }

        let queryIrregular = HKSampleQuery(sampleType: irregularType,
                                           predicate: nil,
                                           limit: HKObjectQueryNoLimit,
                                           sortDescriptors: nil) { (query, results, error) in

            if let result = results?.last as? HKCategorySample {
                print("Hasil IRREGULAR ** \(result.description)")
            }
        }

        HKAuthorize().healthStore?.execute(queryIrregular)
        HKAuthorize().healthStore?.execute(queryHeight)
        HKAuthorize().healthStore?.execute(queryWeigthnew)

    }

    func getAnchor() -> HKQueryAnchor? {
        if let anchorData = userDefault.object(forKey: "Anchor") as? Data {
            return try? NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: anchorData)
        }

        return nil
    }

    func setAnchor(queryAnchor: HKQueryAnchor?) {
        if let queryAnchor = queryAnchor,
           let data = try? NSKeyedArchiver.archivedData(withRootObject: queryAnchor, requiringSecureCoding: true) {
            userDefault.set(data, forKey: "Anchor")
        }
    }
}
