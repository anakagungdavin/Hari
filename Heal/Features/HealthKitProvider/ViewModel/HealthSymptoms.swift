//
//  HealthSymptoms.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 27/10/22.
//

import Foundation
import HealthKit
import SwiftUI

class HealthSymptoms {

//    var healthStore = HKHealthStore()

    func writeSymptoms(symptoms: [String], now: Date, completion: @escaping(Bool, Error?) -> Void) {

        let shortnesBreath = HKCategoryType(HKCategoryTypeIdentifier.shortnessOfBreath)
        let vomit = HKCategoryType(HKCategoryTypeIdentifier.vomiting)
        let headAche = HKCategoryType(HKCategoryTypeIdentifier.headache)
        let chestPain = HKCategoryType(HKCategoryTypeIdentifier.chestTightnessOrPain)

        var listSymptoms: [HKCategoryType] = []

        for symptom in symptoms {
            if symptom == "shortnesBreath" {
                listSymptoms.append(shortnesBreath)
            } else if symptom == "vomit" {
                listSymptoms.append(vomit)
            } else if symptom == "headAche" {
                listSymptoms.append(headAche)
            } else if symptom == "chestPain" {
                listSymptoms.append(chestPain)
            }
        }

        for listSymptom in listSymptoms {

            print("************ SYMPTOMP TEST \(listSymptom)")

            let value: HKCategoryValueSeverity = .moderate
            let symptomsSample = HKCategorySample(type: listSymptom, value: value.rawValue, start: now, end: now)
            HKAuthorize().healthStore?.save(symptomsSample) { success, error in
                if error != nil {
                    print("Error while saving")
                }
            }
        }

//        switch listSymptoms
//        for symptom in symptoms {
//            let symptomsSample = HKCategorySample(type: symptom, value: HKCategoryValueSeverity, start: now, end: now)
//            healthStore.save(symptomsSample)
//        }

    }
}
