//
//  MainContainer.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 09/11/22.
//

import SwiftUI

struct MainContainer: View {

    @State var selectedTab = "house"
    @State var currentDate: Date = Date()
    @ObservedObject var heartRate: HKHeartRate

    var body: some View {
        ZStack {
            switch selectedTab {
            case "house":
                DashboardView()
            case "doc.text.below.ecg":
                CalenderView(currentDate: $currentDate)
            case "books.vertical":
                ProfilePageNew(notification: NotificationHelper(), ecgsViewModel: HKEcgs(), profile: Profile())
            default:
                PreAlertView(notification: NotificationHelper())
            }
            VStack {
                Spacer()
//                Button("Test") {
//                    for BPM in heartRate.heartData {
//                        print(BPM.heartRate)
//                    }
//                }
                CustomTabBar(selectedTab: $selectedTab)
            }
//            }
        }.onAppear(){
            heartRate.observeHeartRate()
        }
    }
}

struct MainContainer_Previews: PreviewProvider {
    static var previews: some View {
        MainContainer(heartRate: HKHeartRate())
    }
}
