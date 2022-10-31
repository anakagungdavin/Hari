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

    @State var selectedTab = "house"

    var body: some View {

        ZStack(content: {
            Color(uiColor: .systemPink)
                .ignoresSafeArea()

            VStack {
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
                }.offset(CGSize(width: 25, height: 10))

                CardBig()
            }

            VStack {
                Spacer()
//                CustomTabBar(selectedTab: $selectedTab)
            }
        })
    }
}
// }

struct CardBig: View {
    private var authProc: HKAuthorize?
    @Environment(\.managedObjectContext) var viewContext

    init() {
        authProc = HKAuthorize()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Automatically sync your readings with Apple Health")
                .font(.largeTitle)
                .bold()
            HStack {
                Image(systemName: "heart.circle.fill").font(.system(size: 30))
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit")
            }
            HStack {
                Image(systemName: "gearshape.2").font(.system(size: 30))
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit")
            }
            HStack {
                Image(systemName: "waveform.path.ecg.rectangle.fill").font(.system(size: 30))
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit")
            }

            HStack(alignment: .top) {
                Image(systemName: "cross.case.fill")
                    .font(.system(size: 30))
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,")

            }
            Button(action: {
                authProc?.authorizeHealthKit(viewContext: viewContext, completion: { success, error in
                    print("done get data")
                })
            }, label: {
                Text("Connect to Apple Health")
                    .padding()
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 34/255, green: 34/255, blue: 86/255))
                    .background(Color(red: 255/255, green: 240/255, blue: 217/255))
                    .custCornerRadius(10, corners: .allCorners)
                    .padding()
            }).padding()

            Spacer()
        }
        .padding()
        .background()
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(20)
        Spacer(minLength: 80)
    }
}

struct PreAlertView_Previews: PreviewProvider {
    static var previews: some View {
        PreAlertView()
    }
}
