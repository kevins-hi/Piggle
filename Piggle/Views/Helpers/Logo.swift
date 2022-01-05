//
//  Logo.swift
//  Piggle
//
//  Created by Kevin Shi on 7/18/21.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        HStack {
            Text("P")
                .foregroundColor(Color("PigColor1"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("i")
                .foregroundColor(Color("PigColor1"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("g")
                .foregroundColor(Color("PigColor2"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("g")
                .foregroundColor(Color("PigColor3"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("l")
                .foregroundColor(Color("PigColor3"))
                .fontWeight(.bold)
                .padding(.horizontal, -4.0)
            Text("e")
                .foregroundColor(Color("PigColor4"))
                .fontWeight(.bold)
                .padding(.horizontal, -5.0)
        }
        .font(.largeTitle)
        .frame(width: 120, height: 60)
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
