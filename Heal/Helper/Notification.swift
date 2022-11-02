////
////  Notification.swift
////  Heal
////
////  Created by Anak Agung Gede Agung Davin on 02/11/22.
////
//
//import Foundation
//import UserNotifications
//
//class NotificationHelper: ObservableObject {
//
//    @Published var isOn: Bool = true
//
//    func notifPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            if success {
//                print("Notification Ready")
//                self.notifSchedule(isOn: self.isOn)
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    func notifSchedule(isOn: Bool) {
//        if isOn {
//            // notification content
//            let content = UNMutableNotificationContent()
//            content.title = "ini namanya judul notifikasi"
//            content.body = "ini namanya isi notifikasi"
//            content.sound = UNNotificationSound.default
//
//            // schedule notification
//            var dateComponents = DateComponents()
//            dateComponents.calendar = Calendar.current
//
//            dateComponents.weekday = 4 // hari ke berapa (1 brarti minggu)
//            dateComponents.hour = 16 // jam keberapa
//            dateComponents.minute = 08 // menit keberapa
//
//            // trigger repeating event (biar muncul terus sekali seminggu)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//            // notification request
//            let uuidString = UUID().uuidString
//            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
//
//            let notificationCenter = UNUserNotificationCenter.current()
//            notificationCenter.add(request) {(error) in
//                if error != nil {
//
//                } else {
//                    print("notification scheduled")
//                }
//
//            }
//        } else if !isOn {
//            cancelNotification()
//            print("********* CANCELLEDD NOTIFNYA **********%%%%%%")
//        }
//    }
//    
//    func cancelNotification() {
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//    }
//
//}
