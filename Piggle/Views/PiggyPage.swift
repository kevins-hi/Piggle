//
//  PiggyPage.swift
//  Piggle
//
//  Created by Kevin Shi on 7/18/21.
//

import SwiftUI

struct PiggyPage: View {
    @State var scale: CGFloat = 1.0
    @State var previousScale: CGFloat = 1.0
    @State var dabadabada = true
    
    var body: some View {
        // Gestures
        let tapNose = TapGesture()
            .onEnded { _ in
                SoundManager.instance.playSound("clown")
            }
        
        let dragTail = DragGesture()
            .onEnded { _ in
                SoundManager.instance.playSound("boing")
            }
        
        let squishPig = MagnificationGesture()
            .onChanged { value in
                previousScale = scale
                scale = value.magnitude
                
                if dabadabada && scale < previousScale {
                    SoundManager.instance.playRandWewewe()
                    dabadabada = false
                }
                else if scale > previousScale {
                    dabadabada = true
                }
            }
            .onEnded { _ in
                dabadabada = true
                scale = 1.0
            }
        
        // View
        VStack {
            Spacer()
            
            ZStack {
                Image("Piggy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .scaleEffect(scale)
                    .gesture(squishPig)
                    .animation(.linear(duration: 0.3))
                
                Ellipse()
                    .fill(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.001))
                    .frame(width: 70, height: 59, alignment: .center)
                    .offset(x: -16, y: -5)
                    .gesture(tapNose)
                
                Rectangle()
                    .fill(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.001))
                    .frame(width: 80, height: 40)
                    .rotationEffect(Angle(degrees: 128))
                    .offset(x: 105, y: -29)
                    .gesture(dragTail)
            }
            
            HStack {
                Text("You just got")
                    .padding([.top, .leading, .bottom])
                
                Button("squished!") {
                    SoundManager.instance.playRandOink()
                }
                .padding([.top, .bottom, .trailing])
            }
            .background(RoundedRectangle(cornerRadius: 15).fill(Color("LightGray")))
            .foregroundColor(Color("DarkGray"))
            .font(.title)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("LightGray"), lineWidth: 1.5)
            )
            .padding()
            
            Spacer()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct PiggyPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PiggyPage()
                .preferredColorScheme(.light)
        }
    }
}
