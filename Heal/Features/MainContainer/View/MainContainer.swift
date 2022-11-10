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

    var body: some View {
        ZStack {
//            VStack {
//                Spacer()
                Text("******** BABIK")
            switch selectedTab {
            case "house":
                PreAlertView(notification: NotificationHelper())
            case "doc.text.below.ecg":
                CalenderView(currentDate: $currentDate)
            case "books.vertical":
                ProfilePageNew(notification: NotificationHelper())
            default:
                PreAlertView(notification: NotificationHelper())
            }
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
//            }
        }
    }
}

struct MainContainer_Previews: PreviewProvider {
    static var previews: some View {
        MainContainer()
    }
}
