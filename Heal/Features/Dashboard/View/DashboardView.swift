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
    
//    let weekdays = [0, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
//    let ecg = [66, 60, 70, 85, 90, 100, 130,140,150,160,170,180,190,200,210,220,230,240]
    
    let weekdays = [0, 1]
    let ecg = [66, 60]
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: true)],
        predicate: NSPredicate(format: "activities == %@", " "),
        animation: .default)
    private var ecgNoActivities: FetchedResults<Ecg>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: true)],
        predicate: NSPredicate(format: "activities != ' '"),
        animation: .default)
    private var ecgComplete: FetchedResults<Ecg>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: true)],
        animation: .default)
    private var allEcgData: FetchedResults<Ecg>
    
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
        NavigationStack{
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
                                .font(.custom("SFProRounded-Light", size: 22))
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
                    .edgesIgnoringSafeArea(.top)
                    
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
                                Image(ecgToday[0].activities == " " ? "box blom lengkap" : "box lengkap")
                                
                                VStack{
                                    Text("Lengkapi Jurnalmu")
                                        .foregroundColor(.white)
                                        .font(.custom("SFProRounded-Semibold", size: 20))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 13)
                                        .padding(.top, 11)
                                    
                                    HStack {
                                        ForEach(ecgToday){ i in
                                            NavigationLink(destination: DetailJournal(ecg:i.avgBPM, date: Date())) {
                                                VStack {
                                                    Image(i.activities == " " ? "bpm aman" : "bpm gak normal")
                                                    Text( "\(Int(i.avgBPM)) BPM")
                                                        .foregroundColor(.white)
                                                        .font(.custom("SFProRounded-Semibold", size: 12))
                                                        .frame(width: 50)
                                                    Text("Direkam : \(i.timeStampECG!, style: .time)")
                                                        .frame(width: 72)
                                                        .foregroundColor(.white)
                                                        .font(.custom("SFProRounded-Semibold", size: 20))
                                                        .minimumScaleFactor(0.01)
                                                        .lineLimit(1)
                                                    
                                                    Spacer()
                                                }
                                                .padding(.leading, 100)
                                            }
                                            
                                            NavigationLink(destination: DetailJournal(ecg:i.avgBPM, date: Date())) {
                                                VStack {
                                                    Image( "ecg kosong")
                                                    Text("N/A")
                                                        .foregroundColor(.white)
                                                        .font(.custom("SFProRounded-Semibold", size: 12))
                                                        .frame(width: 50)
                                                    Spacer()
                                                }.padding(.leading, 40)
                                            }
                                            
                                            NavigationLink(destination: DetailJournal(ecg:i.avgBPM, date: Date())) {
                                                VStack {
                                                    Image(i.activities == " " ? "aktivitas kosong" : "aktivitas aman")
                                                    Text(i.activities == " " ? "N/A" : "Aktivitas tercatat")
                                                        .foregroundColor(.white)
                                                        .font(.custom("SFProRounded-Semibold", size: 12))
                                                        .frame(width: 50)
                                                    Spacer()
                                                }
                                                .padding(.leading, 50)
                                                .padding(.trailing, 120)
                                            }
                                            
                                        } //ForEach
                                    } //HStack
                                } //VStack
                                .frame(width: 330, height: 130)
                            } //Zstack
                        }.padding(EdgeInsets(top: 33, leading: 0, bottom: 0, trailing: 26))
                        
                        Group{
                            VStack{
                                Text("Rangkuman Bulan Ini")
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .font(.custom("SFProRounded-Regular", size: 22))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(todayMonth)
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .font(.custom("SFProRounded-Semibold", size: 12))
                                    .padding(.top, 12)
                                
                                HStack {
                                    ScrollView(.horizontal, showsIndicators: false){
//                                        Chart{
//                                            ForEach(weekdays, id: \.self){ index in
//                                                PointMark(x: .value("Day", weekdays[index]),
//                                                          y: .value("ECG", ecg[index]))
//                                                .foregroundStyle(Color(hex: "60D0B5"))
//                                                //                                                .annotation{
//                                                //                                                    Text("\(ecg[index])")
//                                                //                                                        .font(.footnote)
//                                                //                                                }
//                                            }
//                                        }
//                                        .frame(width: CGFloat(ecg.count) * 50 < 248 ? 248 : CGFloat(ecg.count) * 50,
//                                               height: 155)
////                                        .scaledToFit()
//                                        .chartXScale(range: .plotDimension(padding: 5))
//                                        .chartYScale(range: .plotDimension(padding: 5))
                                        
                                        
                                        Chart{
                                            ForEach(allEcgData){ index in
                                                PointMark(x: .value("Day", DateFormatter.displayDate.string(from: Calendar.current.date(byAdding: .day, value: 0, to: index.timeStampECG!)!)),
                                                          y: .value("ECG",index.avgBPM))
                                                .foregroundStyle(Color(hex: "60D0B5"))
                                            }
                                        }
                                        .frame(width: CGFloat(ecg.count) * 50 < 248 ? 248 : CGFloat(ecg.count) * 50,
                                               height: 155)
                                        .chartYAxis {
                                            AxisMarks(position: .leading, values: .automatic) { value in
                                                AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 1)).foregroundStyle(Color(hex: "F27D87"))
                                                AxisValueLabel() {
                                                    if let intValue = value.as(Int.self) {
                                                        Text("\(intValue)")
                                                        .font(.custom("SFProRounded-Bold",size: 10))
                                                        .foregroundColor(Color(hex: "B2444E"))
                                                    }
                                                }
                                            }
                                        }
                                        .chartXScale(range: .plotDimension(padding: 5))
                                        .chartYScale(range: .plotDimension(padding: 5))
                                        
                                    } //scrollview
    //                                .frame(width: 248, height: 155)
                                    
                                    VStack{
                                        VStack(alignment: .center){
                                            Text("\(ecgComplete.count) / \(ecgNoActivities.count)")
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
                                            ProgressView(value: CGFloat(ecgComplete.count), total: CGFloat(ecgNoActivities.count))
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
                                } //HStack
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
                                    NavigationLink(destination: RitmeJantungView()){
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
                                    }
                                    
                                    NavigationLink(destination: AritmiaView()){
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
                                    }
                                    
                                    NavigationLink(destination: ECGView()){
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
                                    }
                                    
                                    Spacer()
                                } //HStack
                            }
                        }
                        .padding(EdgeInsets(top: 17, leading: 26, bottom: 0, trailing: 26))
                    }
                }//ScrollView
            } //geometry
            .edgesIgnoringSafeArea(.top)
            .background(Color(hex: "FFFFFF"))
            .navigationTitle("Dashboard")
            .navigationBarHidden(true)
        }.accentColor(Color("B2444E"))
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DashboardView()
        }
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
