//
//  OnboardingView.swift
//  Heal
//
//  Created by heri hermawan on 31/10/22.
//

import SwiftUI

var totalViews = 4

struct OnboardingView: View {
    //    @AppStorage("currentView") var currentView = 1
    @State var currentView = 2
    @State var isVisible = false

        var body: some View {
            
            if currentView == 1 {
                FirstScene(
                    currentView: $currentView,
                    imgMascot: "Group 33",
                    imgRect: "Rectangle 17",
                    contentText: "Text2",
                    button: "Group 61"
                )
                    .transition(.opacity)
            } else if currentView == 2 {
                WalkthroughScreen(
                    currentView: $currentView,
                    imgMascot: "Group 96",
                    img: "Tutorial 1",
                    isVisible : $isVisible
                    
                )
            } else if currentView == 3 {
                WalkthroughScreen(
                    currentView: $currentView,
                    imgMascot: "Group 97",
                    img: "Tutorial 1",
                    isVisible : $isVisible
                )
            } else if currentView == 4 {
                WalkthroughScreen(
                    currentView: $currentView,
                    imgMascot: "Group 41",
                    img: "Tutorial 4",
                    isVisible: $isVisible
                )
            }
            
            if currentView == 5 {
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
        Text("Welcome to Dashboard!!")
            .font(.title)
            .padding()
    }
}

struct WalkthroughScreen: View {
//    @AppStorage("currentView") var currentView = 1
    @Binding var currentView : Int
    
    var imgMascot: String
    var img: String
    @Binding var isVisible: Bool
    
    var body: some View {
        ZStack{
            Group{
                Image(img)
                Image(imgMascot)
                    .padding(EdgeInsets(top: 61, leading: 0, bottom: 260, trailing: 0))
            }.padding(EdgeInsets(top: 79, leading: 45, bottom: 184, trailing: 45))
            
            HStack{
                withAnimation(.spring(response: 1, dampingFraction: 3, blendDuration: 0)) {
                    RoundedCorner()
                        .foregroundColor(currentView == 2 ? Color(hex: "F27D87") : .white)
                        .frame(width: currentView == 2 ? 55 : 19, height: 19)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                if currentView != 2 {
                                    currentView = 2
                                    isVisible = false
                                }
                            }
                        }
                }
                
                withAnimation(.spring(response: 1, dampingFraction: 3, blendDuration: 0)) {
                    RoundedCorner()
                        .foregroundColor(currentView == 3 ? Color(hex: "F27D87") : .white)
                        .frame(width: currentView == 3 ? 55 : 19, height: 19)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                if currentView != 3 {
                                    currentView = 3
                                    isVisible = false
                                }
                            }
                        }
                }
                
                withAnimation(.spring(response: 1, dampingFraction: 3, blendDuration: 0)) {
                    RoundedCorner()
                        .foregroundColor(currentView == 4 ? Color(hex: "F27D87") : .white)
                        .frame(width: currentView == 4 ? 55 : 19, height: 19)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                if currentView != 4 {
                                    currentView = 4
                                    isVisible = true
                                }
                            }
                        }
                }
            }
                .padding(EdgeInsets(top: 613, leading: 0, bottom: 131, trailing: 0))
        
            if isVisible {
                ZStack{
                    Image("Rectangle 16")
                    Image("Selanjutnya")
                }
                .padding(EdgeInsets(top: 665, leading: 0, bottom: 54, trailing: 0))
                .onTapGesture {
                    currentView += 1
                }
            }
            
//            VStack{
//                VStack(alignment: .leading){
//                    Image(img)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding()
//                    Spacer(minLength: 0)
//                }
//                .padding()
//                .overlay(
//                    HStack{
//                        withAnimation(.spring(response: 1, dampingFraction: 3, blendDuration: 0)) {
//                            RoundedCorner()
//                                .foregroundColor(currentView == 2 ? Color(hex: "F27D87") : .white)
//                                .frame(width: currentView == 2 ? 55 : 19, height: 19)
//                                .onTapGesture {
//                                    withAnimation(.easeOut) {
//                                        if currentView != 2 {
//                                            currentView = 2
//                                        }
//                                    }
//                                    isVisible = true
//                                }
//                        }
//
//                        withAnimation(.spring(response: 1, dampingFraction: 3, blendDuration: 0)) {
//                            RoundedCorner()
//                                .foregroundColor(currentView == 3 ? Color(hex: "F27D87") : .white)
//                                .frame(width: currentView == 3 ? 55 : 19, height: 19)
//                                .onTapGesture {
//                                    withAnimation(.easeOut) {
//                                        if currentView != 3 {
//                                            currentView = 3
//                                        }
//                                    }
//                                    isVisible = true
//                                }
//                        }
//
//                        withAnimation(.spring(response: 1, dampingFraction: 3, blendDuration: 0)) {
//                            RoundedCorner()
//                                .foregroundColor(currentView == 4 ? Color(hex: "F27D87") : .white)
//                                .frame(width: currentView == 4 ? 55 : 19, height: 19)
//                                .onTapGesture {
//                                    isVisible.toggle()
//                                    withAnimation(.easeOut) {
//                                        if currentView != 4 {
//                                            currentView = 4
//                                        }
//                                    }
//                                }
//                        }
//
//                        Spacer()
//                        Button(
//                            action:{
//                                withAnimation(.easeOut) {
//                                    if currentView <= totalViews || currentView == 2 {
//                                        currentView += 1
//                                    }
//                                }
//                            },
//                            label: {
//                                Image(systemName: "chevron.right")
//                                    .foregroundColor(Color.white)
//                                    .font(.system(size: 35.0, weight: .semibold))
//                                    .frame(width: 55, height: 55)
//                                    .background(Color("BgNextBtn"))
//                                    .clipShape(Circle())
//                                    .padding(17)
//                                    .overlay(
//                                        ZStack{
//                                            Circle()
//                                                .stroke(Color.white.opacity(0.4), lineWidth: 2)
//                                                .padding()
//                                                .foregroundColor(Color.white)
//                                        }
//                                    )
//                            }
//                        )
//                        .disabled(currentView == 3 ? false : true)
//                    }
//                        .padding()
//                    ,alignment: .bottomTrailing
//                )
//            }
        }
        .background(
           LinearGradient(colors: [
               Color(hex: "FFFFFF"),Color(hex: "FFCED2")]
                          ,startPoint: .top, endPoint: .bottom)
       )
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):
                    if currentView <= totalViews {
                        currentView += 1
                    }
                    if currentView == 4 {
                        isVisible = true
                    }
                    case (0..., -30...30):
                    if currentView <= totalViews && currentView != 1{
                        currentView -= 1
                        isVisible = false
                    }
                    default:  print("no clue")
                }
            }
        )
    }
}

struct FirstScene: View {
    @Binding var currentView : Int
    var imgMascot: String
    var imgRect: String
    var contentText: String
    var button: String
    
    var body: some View {
        ZStack{
            Image(imgMascot)
                .padding(.trailing, 231)
            Image(imgRect)
                .padding(EdgeInsets(top: 187, leading: 126, bottom: 475, trailing: 18))
            Image(contentText)
                .padding(EdgeInsets(top: 215, leading: 159, bottom: 493, trailing: 28))
            Image(button)
                .padding(EdgeInsets(top: 699, leading: 78, bottom: 95, trailing: 72))
                .onTapGesture {
                    currentView += 1
                }
        }
        .background(
           LinearGradient(colors: [
               Color(hex: "FFFFFF"),Color(hex: "FFCED2")]
                          ,startPoint: .top, endPoint: .bottom)
       )
    }
}
