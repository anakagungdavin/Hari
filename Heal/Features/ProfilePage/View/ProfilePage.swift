//
//  ProfilePage.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 21/10/22.
//

import SwiftUI

struct ProfilePage: View {

    init() {
            UITableView.appearance().backgroundColor = .clear
    }

    @State private var name = ""
    @State private var doBirth = Date()
    @State private var gender = ""
    @State private var weight = ""
    @State private var height = ""
    @State private var commorbit = ""

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    // ini buat ilustrasi
                    .frame(width: 100, height: 100)
                Form {
                    TextField("Name", text: $name)
                    DatePicker("Date of Birth", selection: $doBirth, displayedComponents: .date)
                    Picker(selection: $gender, label: Text("Gender")) {
                        ForEach(["Male", "Female"], id: \.self) { Text($0).tag($0)
                        }
                    }
                    // Dibuat Keyboard otomatis angka
                    TextField("Weight(kg)", text: $height)
                        .keyboardType(.numberPad)
                    TextField("Height(cm)", text: $height)
                        .keyboardType(.numberPad)
                    // Dibuat selection (milih apa aja)
                    TextField("Commorbit ", text: $commorbit)
                }
                .background(Color.yellow)
                        .navigationTitle("Profile").foregroundColor(Color.blue)
                Button {
                    print("********** \($name)")
                } label: {
                    Text("Sync with Apple Health")
                }
            }
        }.onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
