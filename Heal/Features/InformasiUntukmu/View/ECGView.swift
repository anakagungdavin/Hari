//
//  ECGView.swift
//  Heal
//
//  Created by Joshia Felim Efraim on 11/11/22.
//  swiftlint:disable line_length

import SwiftUI

struct ECGView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "B2444E") as Any]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "B2444E") as Any]
    }
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(colors: [.white, .white, Color(hex: "E37777")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                
                ScrollView{
                    VStack{
                        //                            Text("Apa itu EKG ?")
                        //                                .multilineTextAlignment(.center)
                        //                                .font(.system(size: 38, weight: .semibold, design: .rounded))
                        //                                .foregroundColor(Color(hex: "B2444E"))
                        //                                .frame(width: 400)
                        
                        Group{
                            Text("")
                            Text("")
                        }
                        
                        ZStack{
                            Image("box ecg")
                            
                            VStack{
                                Image("ecg ilus")
                                
                                Text("EKG merekam elektrokadiogram yang menggambarkan denyut elektrik yang membuat jantungmu berdetak. App memeriksa denyut ini untuk mendapatkan detak jantungmu dan melihat apakah serambi dan bilik jantungmu berdetak dengan ritme teratur. Jika tidak, itu merupakan fibriliasi atrium.")
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .frame(width: 314, alignment: .leading)
                                
                            }
                        }
                        Spacer()
                    }
                }
                
            }
        }
        .navigationTitle("Apa itu EKG ?")
        
    }
}

struct ECGView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ECGView()
        }
    }
        
}
