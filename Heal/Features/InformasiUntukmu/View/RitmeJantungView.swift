//
//  RitmeJantungView.swift
//  Heal
//
//  Created by Joshia Felim Efraim on 11/11/22.
//

import SwiftUI

struct RitmeJantungView: View {
    var body: some View {
        NavigationView{
            ZStack{
                
                LinearGradient(colors: [.white, .white, Color(hex: "E37777")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){
                    
                    HStack{
                        Button(){
                            //fungsi balik ke dashboard
                        }label: {
                            Image("chevron left")
                        }.padding()
                            .multilineTextAlignment(.leading)
                        
                        Text("Informasi Untukmu")
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                            .foregroundColor(Color(hex: "B2444E"))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                    ScrollView{
                        VStack{
                            Text("Jenis Ritme Jantung")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 38, weight: .semibold, design: .rounded))
                                .foregroundColor(Color(hex: "B2444E"))
                                .frame(width: 400)
                            
                            Group{
                                Text("")
                                Text("")
                            }
                            
                            Group{
                                
                                Text("Ritme Sinus")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .frame(width: 342, alignment: .leading)
                                   
                                
                                ZStack{
                                    Image("box")
                                        .position(x:200,y:65)
                                    
                                    VStack{
                                        Image("Ritme sinus ilus")
                                        
                                        Text("Ritme sinus menunjukkan bahwa jantungmu berdetak dengan pola yang seragam.")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(width: 314)
                                    }
                                    
                                    
                                }
                                
                            }
                            
                            Group{
                                Text("")
                                Text("")
                            }
                            
                            Group{
                                
                                Text("Fibrilasi Atrium (AFib)")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .frame(width: 342, alignment: .leading)
                                   
                                
                                ZStack{
                                    Image("box 2")
                                        .position(x:200,y:70)
                                    
                                    VStack{
                                        Image("AFib ilus")
                                        
                                        Text("Hasil AF berarti jantung berdetak dalam pola yang tidak teratur. AFib adalah jenis aritmia serius yang paling umum ditemui.")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(width: 314)
                                    }
                                    
                                    
                                }
                                
                            }
                            
                            Group{
                                Text("")
                                Text("")
                            }
                            
                            Group{
                                
                                Text("Detak Jantung Rendah atau Tinggi")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .frame(width: 350, alignment: .leading)
                                   
                                
                                ZStack{
                                    Image("box")
                                        .position(x:200,y:70)
                                    
                                    VStack{
                                        Image("jantung rendah tinggi ilus")
                                            .position(x:185,y:50)
                                        
                                        Text("Jantung berdetak di bawah 50 detak per menit atau di atas 100 detak per menit (DPM).")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(width: 314)
                                    }
                                    
                                    
                                }
                                
                            }
                            
                            Group{
                                Text("")
                                Text("")
                            }
                            
                            Group{
                                
                                Text("Tidak Meyakinkan")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .frame(width: 350, alignment: .leading)
                                   
                                
                                ZStack{
                                    Image("box 2")
                                        .position(x:200,y:80)
                                    
                                    VStack{
                                        Image("tidak meyakinkan ilus")
                                            .position(x:185,y:50)
                                        
                                        Text("Ritme tidak dapat terklarifikasikan dan disebabkan oleh beberapa hal, seperti jenis aritmia yang tidak dikenali oleh app.")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .foregroundColor(Color(hex: "B2444E"))
                                            .frame(width: 314)
                                    }
                                    
                                    
                                }
                                
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            
            
            
            
            
        }
        
    }
}

struct RitmeJantungView_Previews: PreviewProvider {
    static var previews: some View {
        RitmeJantungView()
    }
}
