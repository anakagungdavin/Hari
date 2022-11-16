//
//  ProfilePageModel.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 07/11/22.
//

import Foundation
import HealthKit
import CoreData

class ProfilePageModel {

    func setHealthProfile(viewContext: NSManagedObjectContext,
                          authProc: HKAuthorize) {
        authProc.authorizeHealthKit(viewContext: viewContext) { success, error in
            if success {
                return
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
