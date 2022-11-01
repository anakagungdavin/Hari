//
//  OnboardingView.swift
//  Heal
//
//  Created by heri hermawan on 31/10/22.
//

import SwiftUI

var totalViews = 3

struct OnboardingView: View {
    //    @AppStorage("currentView") var currentView = 1
        @State var currentView = 1
        
        var body: some View {
            
            if currentView == 1 {
                WalkthroughScreen(
                    currentView: $currentView,
                    title: "20% Off For New Customers",
                    description: "On Shopping Cart Cup Holders At Zooblie.",
                    bgColor: "PastelColor",
                    img: "intro_1"
                )
                    .transition(.opacity)
            } else if currentView == 2 {
                WalkthroughScreen(
                    currentView: $currentView,
                    title: "Save on No Cost EMI",
                    description: "Avail No Cost EMI offers at Zooblie.in",
                    bgColor: "VilvetColor",
                    img: "intro_2"
                )
            } else if currentView == 3 {
                WalkthroughScreen(
                    currentView: $currentView,
                    title: "Shopping Offers",
                    description: "Online Shopping Offers on Zooblie, Grab upto 40 to 90% off",
                    bgColor: "OrangeColor",
                    img: "intro_3"
                )
            }
            
            if currentView == 4 {
                Home()
            }
            
        }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct Home: View {
    var body: some View {
        Text("Welcome to Swift UI 4.0!!")
            .font(.title)
            .padding()
    }
}

struct WalkthroughScreen: View {
//    @AppStorage("currentView") var currentView = 1
    @Binding var currentView : Int
    
    var title: String
    var description: String
    var bgColor: String
    var img: String
    
    var body: some View {
        ZStack{
            VStack{
                VStack(alignment: .leading){
                    Image(img)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .font(.title)
                        .padding(.top)
                    
                    
                    Text(description)
                        .padding(.top, 5.0)
                        .foregroundColor(Color.white)
                    Spacer(minLength: 0)
                }
                .padding()
                .overlay(
                    HStack{
                        withAnimation(.spring(response: 1, dampingFraction: 10, blendDuration: 0)) {
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .foregroundColor(currentView == 1 ? .white : .white.opacity(0.5))
                                .frame(width: currentView == 1 ? 25 : 12, height: 5)
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        if currentView != 1 {
                                            currentView = 1
                                        }
                                    }
                                }
                        }
                        
                        RoundedCorner().frame(width: 50, height: 50)
                        
                        withAnimation(.spring(response: 1, dampingFraction: 10, blendDuration: 0)) {
                            ContainerRelativeShape()
                                .foregroundColor(currentView == 2 ? .white : .white.opacity(0.5))
                                .frame(width: currentView == 2 ? 25 : 12, height: 5)
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        if currentView != 2 {
                                            currentView = 2
                                        }
                                    }
                                }
                        }
                        
                        withAnimation(.spring(response: 1, dampingFraction: 10, blendDuration: 0)) {
                            ContainerRelativeShape()
                                .foregroundColor(currentView == 3 ? .white : .white.opacity(0.5))
                                .frame(width: currentView == 3 ? 25 : 12, height: 5)
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        if currentView != 3 {
                                            currentView = 3
                                        }
                                    }
                                }
                        }
                        
                        Spacer()
                        Button(
                            action:{
                                withAnimation(.easeOut) {
                                    if currentView <= totalViews || currentView == 2 {
                                        currentView += 1
                                    } else if currentView == 3 {
                                        currentView = 1
                                    }
                                }
                            },
                            label: {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 35.0, weight: .semibold))
                                    .frame(width: 55, height: 55)
                                    .background(Color("BgNextBtn"))
                                    .clipShape(Circle())
                                    .padding(17)
                                    .overlay(
                                        ZStack{
                                            Circle()
                                                .stroke(Color.white.opacity(0.4), lineWidth: 2)
                                                .padding()
                                                .foregroundColor(Color.white)
                                        }
                                    )
                            }
                        )
                    }
                        .padding()
                    ,alignment: .bottomTrailing
                )
            }
        }
        //.background(Color(bgColor).ignoresSafeArea())
        .background(
                       LinearGradient(colors: [
                           Color(bgColor),Color("BgNextBtn")]
                                      ,startPoint: .top, endPoint: .bottom)
                   )
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):
                    print("left swipe")
                    currentView += 1
                    case (0..., -30...30):
                    print("right swipe")
                    currentView -= 1
                    case (-100...100, ...0):
                    print("up swipe")
                    case (-100...100, 0...):
                    print("down swipe")
                    default:  print("no clue")
                }
            }
        )
    }
}
