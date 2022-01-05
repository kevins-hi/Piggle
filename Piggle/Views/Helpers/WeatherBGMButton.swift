//
//  WeatherBGMButton.swift
//  Piggle
//
//  Created by Kevin Shi on 8/4/21.
//

import SwiftUI

struct WeatherBGMButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        if isPlaying {
            Button(action: {
                isPlaying = false
                SoundManager.instance.stopBackgroundMusic()
            }, label: {
                Image(systemName: "stop.circle.fill")
                    .foregroundColor(Color("Weather1"))
                    .font(.system(size: 25))
                    .frame(width: 60, height: 60)
            })
        } else {
            Button(action: {
                isPlaying = true
                SoundManager.instance.startBackgroundMusic("underwater")
            }, label: {
                Image(systemName: "play.circle.fill")
                    .foregroundColor(Color("Weather1"))
                    .font(.system(size: 25))
                    .frame(width: 60, height: 60)
            })
        }
    }
}

struct WeatherBGMButton_Previews: PreviewProvider {
    static var previews: some View {
        WeatherBGMButton(isPlaying: .constant(false))
    }
}
