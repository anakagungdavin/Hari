//
//  Detail Journal.swift
//  Journal_Sympta
//
//  Created by Nur Mutmainnah Rahim on 02/11/22.
//

import SwiftUI

struct DetailJournal: View {
    @State var PDFurl: URL?
    @State var ShowShareSheet: Bool = false
    @State var isSesak: Bool = false
    @State var isMuntah: Bool = false
    @State var isPusing: Bool = false
    @State var isNyeriDada: Bool = false
    var ecg: Double
    var date: String
    var body: some View {
        VStack {
            Group {
                HStack {
                    Image("IconECG") //ECG Image Icon
                    Text(date) //Date
                    Text("|")
                    Text("10:35") // Date ECG
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .position(x:210, y:45)
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
                    .position(x:240, y:45)
                                
                    Image("ECGraph")
                        .position(x:195, y:95)
                    Text("Ritme Sinus")//Status ECG
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .position(x:240, y:125)
                        .bold()
                        .foregroundColor(Color("ColorText"))
                }
                            
                .background(Color("bgCard").cornerRadius(10).frame(width: 360, height: 200).position(x:195, y: 110))
                             
                            
                Text("Gejala Yang Dirasakan")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .position(x:220, y:160)
                    .foregroundColor(Color("ColorText"))
                            

                //Symptoms
                HStack {
                    Button(action: {
                        self.isSesak.toggle()
                    }){
                        Image(self.isSesak == true ? "Sesak.fill":"Sesak")
                    }
                    Button(action: {
                        self.isMuntah.toggle()
                    }){
                        Image(self.isMuntah == true ? "Muntah.fill":"Muntah")
                    }
                    Button(action: {
                        self.isPusing.toggle()
                    }){
                        Image(self.isPusing == true ? "Pusing.fill":"Pusing")
                    }
                    Button(action: {
                        self.isNyeriDada.toggle()
                    }){
                        Image(self.isNyeriDada == true ? "NyeriDada.fill":"NyeriDada")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .position(x:220, y:135)

                Text("Activitas Yang Dilakukan")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .position(x:220, y:120)
                    .foregroundColor(Color("ColorText"))

                HStack {
                    Image("Olahraga")
                    Image("Makan")
                    Image("Tidur")
                    Image("Kerja")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .position(x:220, y:95)

                Text("Konsumsi Obat")
                    .frame(maxWidth: .infinity, alignment: .leading)
                                .position(x:220, y:75)
                                .foregroundColor(Color("ColorText"))

                HStack {
                    Image("Ya")
                    Image("Tidak")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .position(x:220, y:45)

            }//Group
            Text("Catatan")
                .frame(maxWidth: .infinity, alignment: .leading)
                .position(x:220, y:25)
                .foregroundColor(Color("ColorText"))
            
            Button {
                exportPDF {
                    self
                } completion: { status, url in
                    if let url = url,status{
                        self.PDFurl = url
                        self.ShowShareSheet.toggle()
                    }
                    else{
                        print("failer to produce PDF")
                    }
                }
            } label: {
                Text("Export PDF")

            }

        }//Batas Vstack
        
        .sheet(isPresented: $ShowShareSheet){
            PDFurl = nil
        } content: {
            if let PDFurl = PDFurl {
                ShareSheet(urls: [PDFurl])
            }
            
        }
         

                    
        
    }//batas scroll view
        
    
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
