//
//  Dashboard.swift
//  TesDashboard
//
//  Created by heri hermawan on 13/10/22.
//

import SwiftUI
import CoreData
import Charts

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var dashboardViewModel = DashboardViewModel()
    @State var isPresented = false
    
    let weekdays = Calendar.current.shortWeekdaySymbols
    let ecg = [66, 60, 70, 85, 90, 100, 130]
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: true)],
        predicate: NSPredicate(format: "activity == %@", ""),
        animation: .default)
    private var items: FetchedResults<Ecg>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: true)],
        predicate: NSPredicate(format: "activity != ''"),
        animation: .default)
    private var fullItems: FetchedResults<Ecg>
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                ZStack {
                    Group{
                        HStack{
                            Image("Group 34")
                                .padding(EdgeInsets(top: 32, leading: -39, bottom: 0, trailing: 0))
                            
                            VStack(alignment: .leading){
                                Text("Halo!")
                                    .font(.custom("SFProRounded-Semibold", size: 38))
                                    .foregroundColor(Color(hex: "B2444E"))
                                Text("Selamat datang Oktober")
                                    .font(.custom("SFProRounded-Light", size: 22))
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } //vstack
                            .padding(EdgeInsets(top: 45, leading: 0, bottom: 0, trailing: 0))
                        } //hstack
                        .frame(maxWidth: .infinity)
                    }
                } //zstack
                
                Group{
                    VStack{
                        Text("Lengkapi Jurnalmu")
                            .foregroundColor(.white)
                            .font(.custom("SF Pro Rounded", size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 13)
                            .padding(.top, 11)
                            .padding(.bottom, 19)
                        HStack{
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .padding(.leading, 38)
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .padding(.leading, 67)
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .padding(.leading, 67)
                                .padding(.trailing, 38)
                        }
                        .padding(.bottom, 46)
                    }
                    .frame(width: 330, height: 130)
                    .background(Color(hex: "F27D87")).cornerRadius(10)
                }.padding(EdgeInsets(top: 33, leading: 27, bottom: 0, trailing: 0))
                
            }//ScrollView
        }
        .background(Color(hex: "FFFFFF"))
        .navigationTitle("Dashboard")
    }
}

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
                .frame(width: 250, height: 28)
                .foregroundColor(.blue)
                .overlay(Color.black.opacity(0.5)).cornerRadius(14)
            
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 28)
                .foregroundColor(.yellow)
        }
        .padding()
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
