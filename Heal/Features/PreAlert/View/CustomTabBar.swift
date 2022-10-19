//
//  CustomTabBar.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 15/10/22.
//

import SwiftUI

struct CustomTabBar: View {

    @Binding var selectedTab: String

    var body: some View {

        HStack(spacing: 0) {

            // Tab Bar Buttons...
            TabBarButton(image: "house", selectedTab: $selectedTab)
            TabBarButton(image: "doc.text.below.ecg", selectedTab: $selectedTab)
            TabBarButton(image: "books.vertical", selectedTab: $selectedTab)
            TabBarButton(image: "gear", selectedTab: $selectedTab)

        }
        .padding()
        .background(Color.white)
        .cornerRadius(40)
        .padding(.horizontal)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        PreAlertView()
    }
}

struct TabBarButton: View {

    var image: String
    @Binding var selectedTab: String

    var body: some View {

        // Getting mid point of each button for curve
        GeometryReader { reader in
            Button(action: {

                // changing tab with animation
                withAnimation {
                    selectedTab = image
                }

            }, label: {

                Image(systemName: image)
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(selectedTab == image ? .green : .gray)
                    .offset(y: selectedTab == image ? -5 : 0)
            })
            // Max frame..
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        // Max Height
        .frame(height: 35)
    }

}
