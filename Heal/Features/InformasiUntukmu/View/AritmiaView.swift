//
//  AritmiaView.swift
//  Heal
//
//  Created by Joshia Felim Efraim on 11/11/22.
//

import SwiftUI

struct AritmiaView: View {
    
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
                        //                            Text("Apa itu Aritmia ?")
                        //                                .multilineTextAlignment(.center)
                        //                                .font(.system(size: 38, weight: .semibold, design: .rounded))
                        //                                .foregroundColor(Color(hex: "B2444E"))
                        //                                .frame(width: 400)
                        
                        Group{
                            Text("")
                            Text("")
                        }
                        
                        ZStack{
                            Image("box apa itu aritmia")
                                .position(x:200,y:175)
                            
                            VStack{
                                Image("ilus aritmia")
                                
                                Text("Suatu kondisi dimana jantung berdetak dengan ritme yang tidak  teratur atau tidak normal")
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .frame(width: 314, alignment: .leading)
                                
                                Text("")
                                Text("")
                                
                                Text("Gejalanya ?").font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .frame(width: 314, alignment: .leading)
                                
                                
                                Text("")
                                
                                Group{
                                    Text("Penderita aritmia bisa saja tidak mengalami gejala apapun, atau dapat merasakan gejala :")
                                    Text("• Pusing")
                                    Text("• Pingsan")
                                    Text("• Sakit di dada")
                                    Text("• Dada berdebar debar")
                                }.font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundColor(Color(hex: "B2444E"))
                                    .frame(width: 314, alignment: .leading)
                                
                                Image("ilus aritmia 2")
                                    .position(x:280,y:0)
                            }
                        }
                        Spacer()
                    }
                }
                
                
            }
        }
        .navigationTitle("Apa itu Aritmia ?")
        
    }
}

struct AritmiaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AritmiaView()
        }
        
    }
}
