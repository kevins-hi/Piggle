//
//  BGMButton.swift
//  Piggle
//
//  Created by Kevin Shi on 7/29/21.
//

import SwiftUI

struct BGMButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        if isPlaying {
            Button(action: {
                isPlaying = false
                SoundManager.instance.stopBackgroundMusic()
            }, label: {
                Image(systemName: "stop.circle.fill")
                    .foregroundColor(Color("PigColor1"))
                    .font(.system(size: 25))
                    .frame(width: 60, height: 60)
            })
        } else {
            Button(action: {
                isPlaying = true
                SoundManager.instance.startBackgroundMusic("pigstep")
            }, label: {
                Image(systemName: "play.circle.fill")
                    .foregroundColor(Color("PigColor1"))
                    .font(.system(size: 25))
                    .frame(width: 60, height: 60)
            })
        }
    }
}

struct BGMButton_Previews: PreviewProvider {
    static var previews: some View {
        BGMButton(isPlaying: .constant(false))
    }
}
