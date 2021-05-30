//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Bailey on 16/05/2021.
//

import SwiftUI

enum FlagEffect {
    case spin
    case fall
    case fadeOut
    case enlarge
}

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var flagEffects: [FlagEffect?] = [nil, nil, nil]

    @State private var score = 0
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .pink]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Text("Tap the flag of:")
                    Text(countries[correctAnswer])
                        .fontWeight(.black)
                }

                Spacer()

                VStack(spacing: 48) {
                    ForEach(0 ..< 3) { number in
                        FlagButton(
                            flag: self.countries[number],
                            effect: flagEffects[number]
                        ) {
                            self.flagTapped(number)
                        }
                    }
                }

                Spacer()

                HStack {
                    Text("Your score:")
                    Text("\(score)").fontWeight(.black)
                }
            }
            .padding()
        }
        .foregroundColor(.white)
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("Continue")) {
                    self.nextQuestion()
                }
            )
        })
    }

    func flagTapped(_ number: Int) {
        flagEffects = [.fadeOut, .fadeOut, .fadeOut]

        if number == correctAnswer {
            flagEffects[number] = .spin
            score += 1
            alertTitle = "Correct"
        } else {
            flagEffects[number] = .fall
            flagEffects[correctAnswer] = .enlarge
            alertTitle = "Incorrect"
        }
        alertMessage = "You chose \(countries[number])"

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showingAlert = true
        }
    }

    func nextQuestion() {
        flagEffects = [nil, nil, nil]
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct FlagButton: View {
    let flag: String
    let effect: FlagEffect?
    let action: () -> Void

    var animation: Animation? {
        switch effect {
        case .spin:
            return .spring()
        case .fall:
            return .spring()
        case .fadeOut:
            return .default
        case .enlarge:
            return .easeOut
        default:
            return nil
        }
    }

    var body: some View {
        Button(action: action) {
            Image(flag)
                .renderingMode(.original)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black, radius: 2, x: 0, y: 2)
        .disabled(effect != nil)
        .rotation3DEffect(
            effect == .spin ? .degrees(360) : .zero,
            axis: (x: 0, y: 1, z: 0)
        )
        .rotation3DEffect(
            effect == .fall ? .degrees(-105) : .zero,
            axis: (x: 1, y: 0, z: 0)
        )
        .opacity(effect == .fadeOut ? 0.25 : 1)
        .scaleEffect(effect == .enlarge ? 1.25 : 1)
        .animation(animation)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
