//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Bailey on 16/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)

            VStack(spacing: 32) {
                VStack {
                    Text("Tap the flag of: \(countries[correctAnswer])")
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                }

                Spacer()
            }
        }
        .foregroundColor(.white)
        .alert(isPresented: $showingScore, content: {
            Alert(
                title: Text(scoreTitle),
                message: Text("Your score is ???"),
                dismissButton: .default(Text("Continue")) {
                    self.nextQuestion()
                }
            )
        })
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }

    func nextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
