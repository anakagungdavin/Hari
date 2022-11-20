//
//  PreAlertTest.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 13/11/22.
//

import SwiftUI

struct PreAlertTest: View {
    @EnvironmentObject var authProc: HKAuthorize
    @ObservedObject var notification: NotificationHelper
    var body: some View {
        if UserDefaults.standard.object(forKey: "defaultsView") as? Int == 1 {
            MainContainer(heartRate: HKHeartRate())
        } else {
            ZStack {
                LinearGradient(colors: [.white, Color(hex: "E37777")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                CardBigNew().environmentObject(authProc)
                VStack {
                    HStack {
                        Image("Group 35")
                            .resizable()
                            .frame(width: 120, height: 120)
                    }
                    Spacer()
                }
                .offset(CGSize(width: 100, height: 60))
            }.onAppear(){
                notification.notifPermission()
            }
        }
    }
}

struct CardBigNew: View {
    @EnvironmentObject var authProc: HKAuthorize
    @Environment(\.managedObjectContext) var viewContext
    @State var isShowed = false
    var defaultsView = UserDefaults.standard

    //    init() {
    //        authProc = HKAuthorize()
    //    }

    var body: some View {
        VStack {
            Spacer(minLength: 125)
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                Text("Mengizinkan terhubung dengan Health Apps untuk menyediakan fitur:")
                    .font(.title)
                    .bold()
                HStack {
                    Image("icon 6")
                        .font(.system(size: 50))
                    Spacer(minLength: 5)
                    Text("Menghubungkan data ECG Apple Watch mu")
                        .font(.title3)
                }
                //gabisa sejajar
                HStack {
                    Image("icon 4")
                        .font(.system(size: 50))
                    Spacer()
                    Text("Melihat statistik jantung anda dalam aplikasi kami")
                        .font(.title3)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                HStack {
                    Image("icon 5")
                        .font(.system(size: 50))
                    Spacer(minLength: 5)
                    Text("Memiliki data historis yang bisa di bagikan")
                        .font(.title3)
                }

                Spacer()
                Spacer()
            }
            .padding()
            .background()
            .mask(RoundedCorner(radius: 50, corners: .allCorners))
            .overlay(RoundedCorner(radius: 50, corners: .allCorners)
                .stroke(Color(hex: "E37777"), style: StrokeStyle(lineWidth: 2))
            )
        .padding(20)
            HStack {
                Spacer(minLength: 50)
                Button(action: {
                    // nyari cara buat pindah ke page selanjutnya
                    authProc.authorizeHealthKit(viewContext: viewContext, completion: { success, error in
                        if !success {
                            print("The error \(String(describing: error))")
                        } else {
                            isShowed.toggle()
                            defaultsView.set(1, forKey: "defaultsView")
                        }
                    })
                }, label: {
                    Text("Tinjau Akses")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 34/255, green: 34/255, blue: 86/255))
                        .background(Color(red: 255/255, green: 240/255, blue: 217/255))
                        .custCornerRadius(10, corners: .allCorners)
                    //                    .padding()
                })
                .fullScreenCover(isPresented: $isShowed, content: {
                    MainContainer(heartRate: HKHeartRate())
//                    DashboardView()
                })
                .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                Spacer(minLength: 50)
            }
            Spacer(minLength: 30)
        }

        //        Spacer(minLength: 80)
    }
}

struct PreAlertTest_Previews: PreviewProvider {
    static var previews: some View {
        PreAlertTest(notification: NotificationHelper()).environmentObject(HKAuthorize())
    }
}
