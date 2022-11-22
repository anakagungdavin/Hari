//
//  Detail Journal.swift
//  Journal_Sympta
//
//  Created by Nur Mutmainnah Rahim on 02/11/22.
//

import SwiftUI
import Charts

struct DetailJournal: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var journalData: DetailJournalViewModel
    @State var PDFurl: URL?
    @State var showShareSheet: Bool = false
    @State var isSesak: Bool = false
    @State var isMuntah: Bool = false
    @State var isPusing: Bool = false
    @State var isNyeriDada: Bool = false
    @State var isOlahraga: Bool = false
    @State var isMakan: Bool = false
    @State var isTidur: Bool = false
    @State var isKerja: Bool = false
    @State var isLainnya: Bool = false
    @State var isYa: Bool = false
    @State var isTidak: Bool = false
    var ecg: Double
    var date: String
    var hour: String
    var coreDataItem : Ecg?
    var xPoints: [Double]
    var yPoints: [Double]
    @State var gejala: [String] = []
    @State var aktivitas: String = ""
    @State var obat: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(spacing: 70) {
                    Button {
                        journalData.addItem(viewContext: viewContext)
                    } label: {
                        Text("Simpan")
                            .foregroundColor(Color("ColorText"))
                    }
                    
                    Text("Detail Jurnal")
                        .font(.title2.bold())
                        .foregroundColor(Color("ColorText"))
                    
                    Button() {
                        exportPDF {
                            self
                        } completion: { status, url in
                            if let url = url,status{
                                self.PDFurl = url
                                self.showShareSheet.toggle()
                            }
                            else{
                                print("failer to produce PDF")
                            }
                        }
                        //journalData.addItem(viewContext: viewContext)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color("ColorText"))
                    }
                    //.padding(.leading)
                    .frame(alignment: .topLeading)
                }
                
                Group {
                    HStack {
                        Image("IconECG") //ECG Image Icon
                        Text(date) //Date
                        Text("|")
                        Text(hour) // Date ECG
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .position(x:210, y:25)
                    //Mark : Card Add ECG
                    VStack {
                        HStack {
                            Image("Heart")
                            Text(String(ecg))//BPM Value
                                .bold()
                                .foregroundColor(Color("ColorText"))
                            Text("DPM Rerata")
                                .foregroundColor(Color("ColorText"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .position(x:200, y:25)
                        
                        Chart {
                            ForEach (0...2000, id: \.self) { points in
                                LineMark(
                                    x: .value("time", xPoints[points]),
                                    y: .value("ecg", yPoints[points])
                                )
                            }
                        }
                        .frame(width: 300, height: 200, alignment: .center)
                        .position(x:175, y:45)
                        .foregroundColor(Color(.black))
                        Text("Ritme Sinus")//Status ECG
                        //.frame(maxWidth: .infinity, alignment: .leading)
                            .position(x:70, y:35)
                            .bold()
                            .foregroundColor(Color("ColorText"))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("bgCard")).opacity(1.5)).frame(width: 360, height: 200).position(x:195, y: 100)
                    
                    Text("Gejala Yang Dirasakan")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .position(x:220, y:10)
                        .foregroundColor(Color("ColorText"))
                    
                    
                    //Symptoms
                    HStack {
                        Button(action: {
                            self.isSesak.toggle()
                            if isSesak == true {
                                gejala.append("Sesak")
                            }
                            else {
                                gejala.remove(at: gejala.firstIndex(of: "Sesak")!)
                            }
                            journalData.gejalaku = gejala
                        }){
                            Image(journalData.gejalaku.contains("Sesak") ? "Sesak.fill":"Sesak")
                        }
                        Button(action: {
                            self.isMuntah.toggle()
                            if isMuntah == true {
                                gejala.append("Muntah")
                            }
                            else {
                                gejala.remove(at: gejala.firstIndex(of: "Muntah")!)
                            }
                            journalData.gejalaku = gejala
                        }){
                            Image(journalData.gejalaku.contains("Muntah") ? "Muntah.fill":"Muntah")
                        }
                        Button(action: {
                            self.isPusing.toggle()
                            if isPusing == true {
                                gejala.append("Pusing")
                            }
                            else {
                                gejala.remove(at: gejala.firstIndex(of: "Pusing")!)
                            }
                            journalData.gejalaku = gejala
                        }){
                            Image(journalData.gejalaku.contains("Pusing") ? "Pusing.fill":"Pusing")
                        }
                        Button(action: {
                            self.isNyeriDada.toggle()
                            if isNyeriDada == true {
                                gejala.append("NyeriDada")
                            }
                            else {
                                gejala.remove(at: gejala.firstIndex(of: "NyeriDada")!)
                            }
                            journalData.gejalaku = gejala
                        }){
                            Image(journalData.gejalaku.contains("NyeriDada") ? "NyeriDada.fill":"NyeriDada")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .position(x:220, y:35)
                    
                    Text("Activitas Yang Dilakukan")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .position(x:220, y:10)
                        .foregroundColor(Color("ColorText"))
                    
                    HStack {
                        Button(action: {
                            if (self.isMakan==false && self.isTidur==false && self.isKerja==false && isLainnya==false) {
                                self.isOlahraga.toggle()
                                if isOlahraga==true{
                                    aktivitas = "Olahraga"
                                }
                                else{
                                    aktivitas = ""
                                }
                                journalData.aktivitasku = aktivitas
                            }
                        }){
                            Image(journalData.aktivitasku == "Olahraga"  ? "Olahraga.fill":"Olahraga")
                        }
                        Button(action: {
                            if (self.isOlahraga==false && self.isTidur==false && self.isKerja==false && isLainnya==false) {
                                self.isMakan.toggle()
                                if isMakan==true{
                                    aktivitas = "Makan"
                                }
                                else{
                                    aktivitas = ""
                                }
                                journalData.aktivitasku = aktivitas
                            }
                        }){
                            Image(journalData.aktivitasku == "Makan"  ? "Makan.fill":"Makan")
                        }
                        Button(action: {
                            if (self.isMakan==false && self.isOlahraga==false && self.isKerja==false && isLainnya==false) {
                                self.isTidur.toggle()
                                if isTidur==true{
                                    aktivitas = "Tidur"
                                }
                                else{
                                    aktivitas = ""
                                }
                                journalData.aktivitasku = aktivitas
                            }
                        }){
                            Image(journalData.aktivitasku == "Tidur"  ? "Tidur.fill":"Tidur")
                        }
                        Button(action: {
                            if (self.isMakan==false && self.isTidur==false && self.isOlahraga==false && isLainnya==false) {
                                self.isKerja.toggle()
                                if isKerja==true{
                                    aktivitas = "Kerja"
                                }
                                else{
                                    aktivitas = ""
                                }
                                journalData.aktivitasku = aktivitas
                            }
                        }){
                            Image(journalData.aktivitasku == "Kerja"  ? "Kerja.fill":"Kerja")
                        }
                        Button(action: {
                            if (self.isMakan==false && self.isTidur==false && self.isKerja==false && isOlahraga==false) {
                                self.isLainnya.toggle()
                                if isLainnya==true{
                                    aktivitas = "Lainnya"
                                }
                                else{
                                    aktivitas = ""
                                }
                                journalData.aktivitasku = aktivitas
                            }
                        }){
                            Image(journalData.aktivitasku == "Lainnya" ? "Lainnya.fill":"Lainnya")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .position(x:220, y:35)
                    
                    Text("Konsumsi Obat")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .position(x:220, y:10)
                        .foregroundColor(Color("ColorText"))
                    HStack {
                        Button(action: {
                            if self.isTidak==false {
                                self.isYa.toggle()
                                if isYa==true{
                                    obat = "Ya"
                                }
                                else {
                                    obat = ""
                                }
                            }
                            journalData.konsumsiObat = obat
                            //print(obat)
                            
                            
                        }){
                            Image(journalData.konsumsiObat == "Ya" ? "Ya.fill":"Ya")
                        }
                        Button(action: {
                            if self .isYa == false {
                                self.isTidak.toggle()
                                if isTidak == true {
                                    obat = "Tidak"
                                }
                                else {
                                    obat = ""
                                }
                                journalData.konsumsiObat = obat
                                //print(obat)
                            }
                        }){
                            Image(journalData.konsumsiObat == "Tidak" ? "Tidak.fill":"Tidak")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .position(x:220, y:35)
                }
                // Group
                
                Text("Catatan")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .position(x:220, y:10)
                    .foregroundColor(Color("ColorText"))
                TextEditor(text: $journalData.catatanku)
                //.focused($inFocus, equals: 1)
                    .scrollContentBackground(.hidden)
                    .scrollDismissesKeyboard(.automatic)
                    .background(.white)
                    .frame(width: 350, height: 100, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("bgCard")).opacity(1.5))
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                Spacer(minLength: 200)
                
            }//Batas Vstack
            .onAppear() {
                journalData.editItem(item: coreDataItem)
            }
            .sheet(isPresented: $showShareSheet){
                PDFurl = nil
            } content: {
                if let PDFurl = PDFurl {
                    ShareSheet(urls: [PDFurl])
                }
                
            }
            
            
            
            
        }//batas scroll view
    }
    
}


//Shared sheet
struct ShareSheet: UIViewControllerRepresentable{
    
    var urls: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
 
/*
struct DetailJournal_Preview: PreviewProvider {
    static var previews: some View {
       //DetailJournal(ecg: Cale)
    }
}
*/
//Kode Masher
/*
 NavigationStack{
             ScrollViewReader{ sp in
                 ScrollView{
                     VStack {
                         HStack {
                             Text("Date")
                             Spacer()
                             TextField("Date", text: $dashboardData.ecg)
                                 .multilineTextAlignment(.center)
                                 .frame(width:200)
                                 .background(Color(UIColor(red: 0.623, green: 0.779, blue: 0.753, alpha: 1))).cornerRadius(6)
                         }
                         
                         HStack{
                             Text("Time")
                             Spacer()
                             TextField("Time", text: $dashboardData.activity)
                                 .multilineTextAlignment(.center)
                                 .frame(width:200)
                                 .background(Color(UIColor(red: 0.623, green: 0.779, blue: 0.753, alpha: 1))).cornerRadius(6)
                         }
                         
                         HStack{
                             Text("AVG Heart Rate")
                             Spacer()
                             TextField("AVG Heart Rate", text: $dashboardData.activity)
                                 .multilineTextAlignment(.center)
                                 .frame(width:200)
                                 .background(Color(UIColor(red: 0.623, green: 0.779, blue: 0.753, alpha: 1))).cornerRadius(6)
                         }
                         
                         Image(systemName: "waveform.path.ecg")
                             .resizable()
                             .frame(width: 336, height: 75)
                             .background(Color(UIColor(red: 0.623, green: 0.779, blue: 0.753, alpha: 1))).cornerRadius(6)
                             .padding(.top, 9)
                         
                         Group{
                             HStack{
                                 Text("Symptoms").font(.custom("SFProRounded-Bold", size: 20))
                                 Image(systemName: "questionmark.circle.fill")
                                     .resizable()
                                     .frame(width: 14, height: 14)
                                     .foregroundColor(Color(UIColor(red: 0.623, green: 0.779, blue: 0.753, alpha: 1)))
                                 Spacer()
                             }
                             .padding(.top, 22)
                             
                             Slider(value: $sliderValue, in: 0...5, step: 1)
                                 .onChange(of: sliderValue) { _ in
                                     let impact = UIImpactFeedbackGenerator(style: .medium)
                                     impact.impactOccurred()
                                 }
                         }
                         
                         Group{
                             Text("Activities").frame(maxWidth:.infinity, alignment: .leading)
                                 .font(.custom("SFProRounded-Bold", size: 20))
                             
                             Image(systemName: "figure.walk")
                                 .frame(maxWidth: .infinity, alignment: .leading)
                                 .padding()
                         }
                         
                         Text("Additional Notes").frame(maxWidth:.infinity, alignment: .leading)
                             .font(.custom("SFProRounded-Bold", size: 20))
                         
                         TextEditor(text: $input).id(1)
                             .focused($inFocus, equals: 1)
                             .scrollContentBackground(.hidden)
                             .scrollDismissesKeyboard(.automatic)
                             .background(Color(UIColor(red: 0.623, green: 0.779, blue: 0.753, alpha: 1))).cornerRadius(6)
                             .frame(height: 100)
                             .overlay(RoundedRectangle(cornerRadius: 8)
                                 .stroke(.blue).opacity(0.5))
                             .ignoresSafeArea(.keyboard, edges: .bottom)
                     }
                     .padding([.leading, .trailing], 31)
                 }
                 .onChange(of: inFocus) { id in
                     withAnimation {
                         sp.scrollTo(id)
                     }
                 }
             }
             .onAppear{
                 dashboardData.editItem(item: item)
             }
             .background(Color(UIColor(red: 0.829, green: 0.921, blue: 0.905, alpha: 1)))
             .toolbar {
                 ToolbarItem(placement: .principal) {
                     Text("Journal Detail").font(.title2)
                 }
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button("Save"){
                     }
                 }
                 ToolbarItem(placement: .navigationBarLeading) {
                     Button("Cancel"){
                     }
                     
                 }//scroll view
             }
         }
 */
