//
//  ProfilePageNew.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 31/10/22.
//

import SwiftUI
import CoreData

struct ProfilePageNew: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Profile.name, ascending: true)],
        animation: .default)
    private var itemsProfile: FetchedResults<Profile>
    @FetchRequest(entity: Ecg.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.avgBPM, ascending: true)])
    var profileData: FetchedResults<Ecg>

    @EnvironmentObject var authProc: HKAuthorize
    @ObservedObject var notification: NotificationHelper

    @StateObject var ecgsViewModel: HKEcgs
    @State var selectedTab = "house"
    @State private var name = ""
    @State private var doBirth = Date()
    @State private var gender = ""
    @State private var weight = ""
    @State private var height = ""
    @State private var commorbit = ""
    @State private var custom = true

    let profile: Profile

    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                LinearGradient(colors: [.white, .white, Color(hex: "E37777")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                    Image("Mascot1").frame(alignment: .topLeading)
                        .ignoresSafeArea(.all, edges: .leading)

                VStack {
                    Spacer().frame(minHeight: 10, idealHeight: 75, maxHeight: 600)
                        .fixedSize()

                    HStack {
                        Text("Profile").fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color(hex: "5A0109"))
                        .multilineTextAlignment(.trailing)
                        Spacer()
                    }

                    Rectangle().frame(width: .infinity, height: 2).foregroundColor(Color(hex: "E37777"))

                    FieldTitle(title: "Nama", text: $name)
                    DatePicker(selection: $doBirth, displayedComponents: .date) {
                        Text("Tanggal Lahir")
                    }.padding()
                        .foregroundColor(Color(hex: "E37777"))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hex: "E37777"), style: StrokeStyle(lineWidth: 2))
                    )
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .font(.title3)
                    .frame(maxWidth: .infinity)

                    Group {
                        FieldTitle(title: "Jenis Kelamin", text: $gender)
                        FieldTitle(title: "Tinggi", text: $height)
                        FieldTitle(title: "Berat", text: $weight)
                        FieldTitle(title: "Penyakit Bawaan", text: $commorbit)
                    }

                    HStack {
                        Text("Pengaturan Aplikasi")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(Color(hex: "5A0109"))
                        Spacer()
                    }

                    Rectangle().frame(width: .infinity, height: 2).foregroundColor(Color(hex: "E37777"))

                    Group {
                        Toggle("Notifikasi", isOn: self.$notification.isOn)
                            .onChange(of: self.notification.isOn) { newValue in
                            notification.notifSchedule(isOn: newValue)
                            }
                            .padding()
                            .foregroundColor(Color(hex: "E37777"))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            .font(.title3)
                            .frame(maxWidth: .infinity)

                        Button("Sinkronisasi dengan Apple Health") {

                            ProfilePageModel().setHealthProfile(viewContext: viewContext, authProc: authProc)
                            gender = authProc.getProfile.sexs
                            height = String(authProc.getProfile.height)
                            weight = String(authProc.getProfile.weight)
                            doBirth = authProc.getProfile.dob
                        }
                    }
                }.padding()
            }.navigationTitle("Profile")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }.onDisappear() {
            CoreHelper().addIaddtemProfile(viewContext,
                                           name,
                                           0,
                                           doBirth,
                                           Int32(weight) ?? 0,
                                           Int32(height) ?? 0,
                                           gender,
                                           commorbit)
        }
        .onAppear() {
            name = itemsProfile.last?.name ?? ""
            doBirth = itemsProfile.last?.doBirth ?? Date()
            weight = String(describing: itemsProfile.last?.weight ?? 0)
            height = String(describing: itemsProfile.last?.height ?? 0)
            gender = itemsProfile.last?.sex ?? ""
            commorbit = itemsProfile.last?.commorbit ?? ""

//            ProfilePageModel().setHealthProfile(viewContext: viewContext, authProc: authProc)
//            gender = authProc.getProfile.sexs
//            height = String(authProc.getProfile.height)
//            weight = String(authProc.getProfile.weight)
//            doBirth = authProc.getProfile.dob
//
//            print("************* ANJAYYYYY \(profileData.last?.avgBPM)")
        }
    }
}

struct ProfilePageNew_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageNew(notification: NotificationHelper(), ecgsViewModel: HKEcgs(), profile: Profile()).environmentObject(HKAuthorize())
    }
}

struct FieldTitle: View {

    var title: String
    var text: Binding<String>

    var body: some View {

            HStack {
                Text(title)
                    .font(.title3)
                    TextField(title, text: text)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .multilineTextAlignment(.trailing)

            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .foregroundColor(Color(hex: "E37777"))
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: "E37777"), style: StrokeStyle(lineWidth: 2))
            )

    }
}

struct Field: View {
    var title: String
    var text: Binding<String>

    var body: some View {
        TextField(title, text: text)
            .padding()
            .foregroundColor(Color(hex: "E37777"))
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: "E37777"), style: StrokeStyle(lineWidth: 2))
            )
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .font(.title3)
            .frame(maxWidth: .infinity)
    }
}
