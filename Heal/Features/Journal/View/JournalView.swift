//
//  JournalView.swift
//  Journal_Sympta
//
//  Created by Nur Mutmainnah Rahim on 11/10/22.
//

import SwiftUI

//You will see view of Journal
struct JournalView: View {
    //inisialisasi variabel
    @State var currentDate: Date = Date() //Current Date
    //content
    var body: some View {
        NavigationView {
            //scrollable
            ScrollView(.vertical, showsIndicators: false) {
                //vertical view
                VStack(spacing: 20) { //give space each content in vstack
                    //get current date from "CalenderView.swift"
                    CalenderView(currentDate: $currentDate)
                }
            }
        }
    }
}

struct JournalViewPreview: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
