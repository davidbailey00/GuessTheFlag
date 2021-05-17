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
            LinearGradient(
                gradient: Gradient(colors: [.blue, .pink]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)

            VStack {
                VStack {
                    Text("Tap the flag of:")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                VStack(spacing: 32) {
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            Image(self.countries[number])
                                .renderingMode(.original)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                    }
                }

                Spacer()
            }
            .padding()
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
