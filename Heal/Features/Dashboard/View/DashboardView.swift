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
    
//    let weekdays = Calendar.current.shortWeekdaySymbols
//    let ecg = [66, 60, 70, 85, 90, 100, 130]
    
    let weekdays = [0, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
    let ecg = [66, 60, 70, 85, 90, 100, 130,140,150,160,170,180,190,200,210,220,230,240]
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: true)],
        predicate: NSPredicate(format: "activities == %@", ""),
        animation: .default)
    private var items: FetchedResults<Ecg>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: true)],
        predicate: NSPredicate(format: "activities != ''"),
        animation: .default)
    private var fullItems: FetchedResults<Ecg>
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: false)],
//        predicate: NSPredicate(format: "activities == %@", ""))
//    private var ecgToday: FetchedResults<Ecg>
//
    @FetchRequest private var ecgToday: FetchedResults<Ecg>
    
    init() {
        let request: NSFetchRequest<Ecg> = Ecg.fetchRequest()
        request.predicate = NSPredicate(format: "activities == %@", " ")

        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: false)
        ]

        request.fetchLimit = 1
        _ecgToday = FetchRequest(fetchRequest: request)
    }
    
    let todayMonth = DateFormatter.displayMonth.string(from: Calendar.current.date(byAdding: .day, value: 0, to: Date())!)
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                ZStack {
                    VStack{
                        Image("kotak dashboard atas")
                            .resizable()
                            .frame(width: 390, height: 174)
                        Spacer()
                    }
                    
                    Image("maskot dashboard")
                        .frame(maxWidth: .infinity, alignment: Alignment(horizontal: .leading, vertical: .bottom))
                        .padding(EdgeInsets(top: 79, leading: -39, bottom: 0, trailing: 0))
                    
                    VStack(alignment: .leading){
                        Text("Halo!")
                            .font(.custom("SFProRounded-Semibold", size: 38))
                            .foregroundColor(Color(hex: "B2444E"))
                        Text("Selamat datang \(todayMonth)")
                            .frame(width: 250)
                            .font(.custom("SFProRounded-Light", size: 222))
                            .foregroundColor(Color(hex: "B2444E"))
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                    } //vstack
                    .padding(EdgeInsets(top: 20, leading: 125, bottom: 0, trailing: 30))
                    
                    HStack{
                        ForEach(0..<4, id: \.self){ i in
                            ZStack{
                                Image("card tanggal")
                                    .opacity(i == 0 ? 1 : 0)

                                VStack{
                                    Text(DateFormatter.displayDay.string(from: Calendar.current.date(byAdding: .day, value: i, to: Date())!))
                                        .font(.custom("SFProRounded-Light", size: 20))
                                        .foregroundColor(Color(hex: "B2444E"))
                                    Text(DateFormatter.displayDate.string(from: Calendar.current.date(byAdding: .day, value: i, to: Date())!))
                                        .foregroundColor(Color(hex: "B2444E"))
                                        .font(.custom("SFProRounded-Semibold", size: 20))
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 190, leading: 110, bottom: 0, trailing: 20))
                } //ZStack
                .edgesIgnoringSafeArea([.top, .bottom])
                
//                HStack{
//                    ForEach(0..<4, id: \.self){ i in
//                        ZStack{
//                            Image("card tanggal")
//                                .opacity(i == 0 ? 1 : 0)
//
//                            VStack{
//                                Text(DateFormatter.displayDay.string(from: Calendar.current.date(byAdding: .day, value: i, to: Date())!))
//                                    .font(.custom("SFProRounded-Light", size: 20))
//                                    .foregroundColor(Color(hex: "B2444E"))
//                                Text(DateFormatter.displayDate.string(from: Calendar.current.date(byAdding: .day, value: i, to: Date())!))
//                                    .foregroundColor(Color(hex: "B2444E"))
//                                    .font(.custom("SFProRounded-Semibold", size: 20))
//                            }
//                        }
//                    }
//                }
//                .padding(EdgeInsets(top: -50, leading: 100, bottom: 0, trailing: 0))
                
                VStack{
                    Group{
                        ZStack {
                            Image("box blom lengkap")
                            
                            VStack{
                                Text("Lengkapi Jurnalmu")
                                    .foregroundColor(.white)
                                    .font(.custom("SFProRounded-Semibold", size: 20))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 13)
                                    .padding(.top, 11)
                                
                                HStack {
                                    ForEach(ecgToday){ i in
                                        VStack {
                                            Image(i.activities == "" ? "bpm aman" : "bpm gak normal")
                                            Text( "\(i.avgBPM) BPM")
                                                .foregroundColor(.white)
                                                .font(.custom("SFProRounded-Semibold", size: 12))
                                                .frame(width: 50)
                                            Text("Direkam : 00:00")
                                                .foregroundColor(.white)
                                                .font(.custom("SFProRounded-Semibold", size: 10))
                                                .frame(width: 80)
                                            Spacer()
                                        }.padding(.leading, 100)
                                        
                                        VStack {
                                            Image( "ecg kosong")
                                            Text("N/A")
                                                .foregroundColor(.white)
                                                .font(.custom("SFProRounded-Semibold", size: 12))
                                                .frame(width: 50)
                                            Spacer()
                                        }.padding(.leading, 52)
                                        
                                        VStack {
                                            Image(i.activities == " " ? "aktivitas kosong" : "aktivitas aman")
                                            Text("88 BPM")
                                                .foregroundColor(.white)
                                                .font(.custom("SFProRounded-Semibold", size: 12))
                                                .frame(width: 50)
                                            Spacer()
                                        }.padding(.leading, 52)
                                            .padding(.trailing, 120)
                                    } //ForEach
                                } //HStack
                            } //VStack
                            .frame(width: 330, height: 130)
                        } //Zstack
                    }.padding(EdgeInsets(top: 33, leading: 0, bottom: 0, trailing: 026))
                    
                    Group{
                        VStack{
                            Text("Rangkuman Bulan Ini")
                                .foregroundColor(Color(hex: "B2444E"))
                                .font(.custom("SFProRounded-Regular", size: 22))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack {
                                ScrollView(.horizontal, showsIndicators: false){
                                    Chart{
                                        ForEach(weekdays, id: \.self){ index in
                                            PointMark(x: .value("Day", weekdays[index]), y: .value("ECG", ecg[index]))
                                        }
                                    }
                                    .frame(width: CGFloat(ecg.count) * 50)
                                    .scaledToFit()
                                } //scrollview
                                .frame(width: 248, height: 155)
                                
                                VStack{
                                    VStack(alignment: .center){
                                        Text("\(Int(10)) / \(Int(14))")
                                            .font(.custom("SFProRounded-Semibold", size: 20))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        Text("Jurnal")
                                            .font(.custom("SFProRounded-Light", size: 12))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        Text("Lengkap")
                                            .font(.custom("SFProRounded-Light", size: 12))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        ProgressView(value: 10, total: 14)
                                            .tint(Color(hex: "F27D87"))
                                            .background(Color(hex: "FFCED2"))
                                            .padding(EdgeInsets(top: 0, leading: 9, bottom: 0, trailing: 9))
                                            .scaleEffect(x: 1, y: 1.5, anchor: .center)
                                    }.frame(width: 90, height: 76)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(hex: "FFCED2"))
                                        }
                                        .padding(.trailing, 32)
                                    
                                    VStack(alignment: .center){
                                        Text("8")
                                            .font(.custom("SFProRounded-Semibold", size: 20))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        Text("Gejala")
                                            .font(.custom("SFProRounded-Light", size: 12))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        Text("terdeteksi")
                                            .font(.custom("SFProRounded-Light", size: 12))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        Text("bulan ini")
                                            .font(.custom("SFProRounded-Light", size: 12))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                    }.frame(width: 90, height: 76)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(hex: "FFCED2"))
                                        }
                                        .padding(.trailing, 32)
                                } //VStack
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 17, leading: 28, bottom: 0, trailing: 26))
                    
                    Group{
                        VStack{
                            Text("Informasi Untukmu")
                                .foregroundColor(Color(hex: "B2444E"))
                                .font(.custom("SFProRounded-Regular", size: 22))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(alignment: .center) {
                                VStack(alignment: .center){
                                    Image("jenis aritmia ilus")
                                    Text("Jenis")
                                        .font(.custom("SFProRounded-Semibold", size: 20))
                                        .foregroundColor(Color(hex: "B2444E"))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Text("Aritmia")
                                        .font(.custom("SFProRounded-Semibold", size: 20))
                                        .foregroundColor(Color(hex: "B2444E"))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }.frame(width: 100, height: 100)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(hex: "FFCED2"))
                                    }
                                    .padding(.trailing, 18)
                                
                                VStack(alignment: .center){
                                    Image("apa itu aritmia ilus")
                                    Text("Apa itu")
                                        .font(.custom("SFProRounded-Semibold", size: 20))
                                        .foregroundColor(Color(hex: "B2444E"))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Text("Aritmia?")
                                        .font(.custom("SFProRounded-Semibold", size: 20))
                                        .foregroundColor(Color(hex: "B2444E"))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }.frame(width: 100, height: 100)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(hex: "FFCED2"))
                                    }
                                    .padding(.trailing, 18)
                                
                                VStack(alignment: .center){
                                    Image("apa itu EKG ilus")
                                    Text("Apa itu")
                                        .font(.custom("SFProRounded-Semibold", size: 20))
                                        .foregroundColor(Color(hex: "B2444E"))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Text("EKG ?")
                                        .font(.custom("SFProRounded-Semibold", size: 20))
                                        .foregroundColor(Color(hex: "B2444E"))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }.frame(width: 100, height: 100)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(hex: "FFCED2"))
                                    }
                                
                                Spacer()
                            } //HStack
                        }
                    }
                    .padding(EdgeInsets(top: 17, leading: 26, bottom: 0, trailing: 26))
                }
            }//ScrollView
        } //geometry
        .edgesIgnoringSafeArea([.top, .bottom])
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

extension DateFormatter {
    static let displayDate: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "dd"
         return formatter
    }()
    
    static let displayDay: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "E"
         return formatter
    }()
    
    static let displayMonth: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "MMMM"
         return formatter
    }()
}
