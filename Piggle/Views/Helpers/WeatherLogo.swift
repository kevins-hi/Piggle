//
//  WeatherLogo.swift
//  Piggle
//
//  Created by Kevin Shi on 8/4/21.
//

import SwiftUI

struct WeatherLogo: View {
    var body: some View {
        HStack {
            Text("P")
                .foregroundColor(Color("Weather1"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("i")
                .foregroundColor(Color("Weather1"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("g")
                .foregroundColor(Color("Weather2"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("g")
                .foregroundColor(Color("Weather3"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("l")
                .foregroundColor(Color("Weather3"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("e")
                .foregroundColor(Color("Weather4"))
                .fontWeight(.bold)
                .padding(.horizontal, -5.0)
        }
        .font(.largeTitle)
        .frame(width: 120, height: 60)
    }
}

struct WeatherLogo_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLogo()
    }
}
