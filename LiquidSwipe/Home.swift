//
//  Home.swift
//  LiquidSwipe
//
//  Created by Shishir_Mac on 18/10/24.
//

import SwiftUI

struct Home: View {
    
    @State var offset: CGSize = .zero
    @State var showHome: Bool = false
    
    var body: some View {
        ZStack {
            Color("BGColor")
                .overlay(
                    VStack(alignment: .leading, spacing: 30, content: {
                        Text("From Programmers")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Text("This project work on Liquid Swipe using SwiftUI.")
                            .font(.caption)
                            .fontWeight(.bold)
                    })
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .offset(x: -15)
                )
                .clipShape(LiquidSwipe(offset: offset))
                .ignoresSafeArea()
                .overlay(
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    withAnimation(.interactiveSpring(response: 0.7,
                                                                     dampingFraction: 0.6,
                                                                     blendDuration: 0.6)) {
                                        offset = value.translation
                                    }
                                })
                                .onEnded({ value in
                                    let screen = UIScreen.main.bounds
                                    
                                    withAnimation(.spring()) {
                                        if -offset.width > screen.width / 2 {
                                            offset.width = -screen.height
                                            showHome.toggle()
                                        } else {
                                            offset = .zero
                                        }
                                    }
                                })
                        )
                        .offset(x: 15, y: 50)
                        .opacity(offset == .zero ? 1 : 0), alignment: .topTrailing
                )
                .padding(.trailing)
            
            if showHome {
                Text("Welcome To Home")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            offset = .zero
                            showHome.toggle()
                        }
                    }
            }
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

