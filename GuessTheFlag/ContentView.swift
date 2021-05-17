//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Bailey on 16/05/2021.
//

import SwiftUI

struct ContentView: View {
    let countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ]
    var correctAnswer = Int.random(in: 0 ... 2)

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)

            VStack(spacing: 32) {
                VStack {
                    Text("Tap the flag of: \(countries[correctAnswer])")
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        // flag was tapped
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                }

                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
