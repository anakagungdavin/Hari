//
//  PreAlertPage.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 11/10/22.
//  swiftlint: disable multiple_closures_with_trailing_closure

import Foundation
import SwiftUI
import CoreData

struct PreAlertView: View {
    @EnvironmentObject var authProc: HKAuthorize
    @State var selectedTab = "house"
    @ObservedObject var notification: NotificationHelper

    var body: some View {
        NavigationView {
            ZStack(content: {
                LinearGradient(colors: [.white, Color(hex: "E37777")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    HStack {
                        ZStack {
                            Rectangle(
                            )
                            .frame(width: 100, height: 100)
    //                        .cornerRadius(10)
                            .custCornerRadius(10, corners: .allCorners)
                            .foregroundColor(.white)

                            Image("HeartAsset")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)

                        }
                        Spacer()
                    }.offset(CGSize(width: 25, height: 20))

                    CardBig().environmentObject(authProc)
                    NavigationLink {
                        ProfilePageNew(notification: self.notification).environmentObject(authProc)
                    } label: {
                        Text("Next Screen")
                            .navigationTitle("")
                            .navigationBarHidden(true)
                    }.navigationBarBackButtonHidden(true)
                }

                VStack {
                    Spacer()
    //                CustomTabBar(selectedTab: $selectedTab)
                }
            })
        }
        .onAppear() {
            NotificationHelper().notifPermission()
        }
    }
}
// }

struct CardBig: View {
    @EnvironmentObject var authProc: HKAuthorize
    @Environment(\.managedObjectContext) var viewContext

    //    init() {
    //        authProc = HKAuthorize()
    //    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Mengizinkan terhubung dengan Health Apps untuk menyediakan fitur:")
                .font(.title)
                .bold()
            HStack {
                Image(systemName: "heart.circle.fill").font(.system(size: 35))
                Text("Menghubungkan data ECG Apple Watch mu")
            }
            HStack {
                Image(systemName: "gearshape.2").font(.system(size: 35))
                Text("Melihat statistik jantung anda dalam aplikasi kami")
            }
            HStack {
                Image(systemName: "waveform.path.ecg.rectangle.fill").font(.system(size: 35))
                Text("Memiliki data historis yang bisa di bagikan")
            }

            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    authProc.authorizeHealthKit(viewContext: viewContext, completion: { success, error in
                        if !success {
                            print("The error \(String(describing: error))")
                        }
                    })
                }, label: {
                    Text("Tinjau Akses")
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 34/255, green: 34/255, blue: 86/255))
                        .background(Color(red: 255/255, green: 240/255, blue: 217/255))
                        .custCornerRadius(10, corners: .allCorners)
                    //                    .padding()
            }).multilineTextAlignment(.center)
                Spacer()
            }

            Spacer()
        }
        .padding()
        .background()
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(20)
        
        //        Spacer(minLength: 80)
    }
}

struct PreAlertView_Previews: PreviewProvider {
    static var previews: some View {
        PreAlertView(notification: NotificationHelper())
    }
}
