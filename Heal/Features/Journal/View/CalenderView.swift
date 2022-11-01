//
//  CalenderView.swift
//  Journal_Sympta
//
//  Created by Nur Mutmainnah Rahim on 11/10/22.
//

import SwiftUI
//show UI Calender
struct CalenderView: View {
    //initialisation variabel "currentDate" from "JournalView.swift"
    @Binding var currentDate: Date
    
    //Month update on arrow button click
    @State var currentMonth: Int = 0
    
    //list of content view
    var body: some View {
        //vertical content
        VStack (spacing: 50){
            //write tittle
            Text("Journal")
                .font(.largeTitle.bold()) //font
                .frame(maxWidth: .infinity, alignment: .leading) //align left
                .position(x:210, y:45)
            VStack {
                //month, year and symbol inline
                Text("")
                HStack (spacing: 20){
                    //Month
                    Text(extraDate()[0])
                    //Modification
                        .font(.title2.bold())
                        .position(x:90, y:12)
                    
                    //year
                    /*
                     Text("")
                     //Modification year
                     .fontWeight(.semibold)
                     .font(.system(size: 22))
                     */
                    //allign left all text (month&year)
                    //Spacer(minLength: 0)
                    
                    //button left
                    Button {
                        withAnimation{
                            currentMonth -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    
                    //button right
                    Button {
                        withAnimation{
                            currentMonth += 1
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    //get space tittle and calender
                    .padding(.horizontal,30)
                }
                
                //days
                //list days
                let days: [String] = ["Min","Sen","Sel","Rab","Kam","Jum","Sab"]
                //show days inline
                HStack(spacing: -20) {
                    ForEach(days,id: \.self){ day in
                        Text(day)
                        //.font(.callout)
                        //.fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(15)
                }
                
                //Show date in here
                
                
                //dates
                //masukkan tanggal ke tiap kolom hari(day)
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                LazyVGrid(columns: columns,spacing: 15) {
                    ForEach(extractDate()){value in
                        CardView(value: value)
                            .background(
                                Capsule()
                                    .fill(.green)
                                    .padding(.horizontal,8)
                                    .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                
                            )
                            .onTapGesture {
                                currentDate = value.date
                            }
                        
                    }
                }
                .padding(.top,-20)
                .padding(12)
            }
            .background(Rectangle()
                .fill(Color("bgCalender"))
                .frame(width:360, height:500))
            .cornerRadius(50)
            
            Text("Your Journal")
                .font(.title2.bold()) //font
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .padding(.top,-40)
                .padding(.bottom,-120)
            
            HStack {
                VStack {
                    if let card = cards.first(where: { card in
                        return isSameDay(date1: card.cardDate, date2: currentDate)
                    }){
                        ForEach(card.cardList){ card in
                            HStack {
                                VStack {
                                    Image(systemName: "waveform.path.ecg")
                                        .resizable()
                                        .frame(width: 24, height: 8)
                                    Text(card.BPM)
                                        .font(.custom("SFProRounded-Bold", size: 20))
                                    Text("BPM")
                                        .font(.custom("SFProRounded-Bold", size: 10))
                                }
                                .frame(width: 91, height: 70)
                                .background(Color(UIColor(red: 1, green: 0.929, blue: 0.968, alpha: 1))).cornerRadius(5)
                                .padding(.leading, 9)
                                
                                VStack{
                                    HStack {
                                        Text("08 : 34 AM")
                                            .font(.custom("SFProRounded-Regular", size: 10))
                                            .background(Color(UIColor(red: 1, green: 0.929, blue: 0.968, alpha: 1))).cornerRadius(5)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.top, 5)
                                            .padding(.leading, 10)
                                            .padding(.bottom, 2)
                                        Text("belum lengkap")
                                            .padding(.leading,-35)
                                        //edit
                                        NavigationLink("edit", destination: SecondPage())
                                    }
                                    Text("complete your data")
                                        .font(.custom("SFProRounded-Regular", size: 10))
                                        .frame(width: 209, height: 48)
                                        .background(Color(UIColor(red: 1, green: 0.929, blue: 0.968, alpha: 1))).cornerRadius(5)
                                        .padding(.bottom, 5)
                                        .padding(.leading, 10)
                                        .padding(.trailing, 9)
                                }
                            }
                        }
                        .frame(width: 328, height: 80)
                        .background(Color(UIColor(red: 846, green: 0.677, blue: 0.769, alpha: 1))).cornerRadius(10)
                    }
                    else {
                        Text("No EKG Found")
                    }
                    
                }

            }
            
        }
        .onChange(of: currentMonth) { newValue in
            //update month
            currentDate = getCurrentMonth()
            
        }
 
    }
    @ViewBuilder
    func CardView(value: DateValue)-> some View{
        VStack {
            if value.day != -1{
                //mark kalau ada card
                if let card = cards.first(where: { card in
                    return isSameDay(date1: card.cardDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .foregroundColor(isSameDay(date1: card.cardDate, date2: currentDate) ? .white: .primary)
                        .frame(maxWidth: .infinity)
                    
                    
                    Circle()
                        .fill(isSameDay(date1: card.cardDate, date2: currentDate) ? .white: .blue)
                        .frame(width: 5, height: 5)
                }
                else {
                    //tanggal hari ini
                    Text("\(value.day)")
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .black : .primary)
                        .frame(maxWidth: .infinity)
                }
                

                
            }
        }
        
    }
    
    //checking dates
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    //extraxting year and month
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: "")
    }
    
    func getCurrentMonth()->Date{
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    //fungsi buat ngambil kumpulan tanggal
    func extractDate()->[DateValue]{
        
        let calendar = Calendar.current
        
        //getting current month date
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            //getting day
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
            
        }
        //adding offset days to get exact week
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }

     
    
}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//extending date to get current month dates
extension Date{
    func getAllDates()->[Date]{
        let calendar = Calendar.current
        
        //getting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // getting date
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to:startDate)!
        }
    }
}

//kode masher
/*
                        VStack{
                            Image(systemName: "waveform.path.ecg")
                                .resizable()
                                .frame(width: 24, height: 8)
                            
                            Text("88")
                                .font(.custom("SFProRounded-Bold", size: 20))
                            Text("BPM")
                                .font(.custom("SFProRounded-Bold", size: 10))
                            
                        }
                        .frame(width: 91, height: 70)
                        .background(Color(UIColor(red: 1, green: 0.929, blue: 0.968, alpha: 1))).cornerRadius(5)
                        .padding(.leading, 9)
                        
                        VStack{
                            Text("08 : 34 AM")
                                .font(.custom("SFProRounded-Regular", size: 10))
                                .background(Color(UIColor(red: 1, green: 0.929, blue: 0.968, alpha: 1))).cornerRadius(5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 5)
                                .padding(.leading, 10)
                                .padding(.bottom, 2)
                            Text("complete your data")
                                .font(.custom("SFProRounded-Regular", size: 10))
                                .frame(width: 209, height: 48)
                                .background(Color(UIColor(red: 1, green: 0.929, blue: 0.968, alpha: 1))).cornerRadius(5)
                                .padding(.bottom, 5)
                                .padding(.leading, 10)
                                .padding(.trailing, 9)
                        }
                    }
                    .frame(width: 328, height: 80)
                    .background(Color(UIColor(red: 846, green: 0.677, blue: 0.769, alpha: 1))).cornerRadius(10)
*/
