//
//  ContentView.swift
//  HWSRockPaperScissors
//
//  Created by Steven Robertson on 10/17/19.
//  Copyright © 2019 Steven Robertson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var yourChoice = 0
    @State private var shouldWin = Bool.random()
    @State private var appChoice = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var round = 0
    @State private var alertData: AlertData? = nil

    let moves = ["rock", "paper", "scissors"]
    let rpsImages = ["icons8-hand-rock-500","icons8-hand-500","icons8-hand-scissors-50"]
    
    struct AlertData: Identifiable {
        var id = UUID()
        let title: String
        let message: String
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                Text("Rock-Paper-Scissors")
                    .font(.largeTitle)
                Text("Rock-Paper-Scissors has chosen \(self.moves[appChoice])")
                if shouldWin {
                    Text("Try to win")
                } else {
                    Text("Try to lose")
                }
            }
            HStack {
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.choiceTapped(number)
                    })
                    {
                        Image(self.rpsImages[number])
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
                            }.alert(item: $alertData) { alertData in
                                Alert(title: Text(alertData.title),
                                      message: Text(alertData.message))
                            }
            Text("Your score is \(score) out of \(round)")
        }
    }
    
    func choiceTapped(_ number: Int) {
        print("shouldWin: \(shouldWin) appChoice \(self.appChoice) number \(number)")
        if number == appChoice {
            self.alertData = AlertData(title: "Oops",
            message: "That's not how you play!")
        } else if checkAnswer(shouldWin: shouldWin, appChoice: appChoice, yourChoice: number)
                {
                score += 1
                round += 1
                    if round == 10 {
                        self.alertData = AlertData(title: "Right",
                        message: "Game over. \nYour final score is \(score) out of 10")
                        gameOver()
                    } else {
                self.alertData = AlertData(title: "Right",
                message: "Round: \(round)")
                playGame()
            }
        } else {
            round += 1
            if round == 10 {
                self.alertData = AlertData(title: "Wrong",
                message: "Game over. \nYour final score is \(score) out of 10")
                gameOver()
            } else {
            self.alertData = AlertData(title: "Wrong",
            message: "Round: \(round)")
            playGame()
            }
        }
    }
    
    func checkAnswer(shouldWin: Bool, appChoice: Int, yourChoice: Int) -> Bool {
        if (shouldWin && appChoice==0 && yourChoice==1)
        ||  (shouldWin && appChoice==1 && yourChoice==2)
        ||  (shouldWin && appChoice==2 && yourChoice==0)
        ||  (!shouldWin && appChoice==0 && yourChoice==2)
        ||  (!shouldWin && appChoice==1 && yourChoice==0)
        ||  (!shouldWin && appChoice==2 && yourChoice==1)
        {
        return true
        } else {
        return false
        }
    }
    
    func playGame() {
        shouldWin = Bool.random()
        appChoice = Int.random(in: 0...2)
    }


    func gameOver() {
        score = 0
        round = 0
        shouldWin = Bool.random()
        appChoice = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
           // .environment(\EnvironmentValues.colorScheme, ColorScheme.dark)
        //Dark mode not working in the canvas this time
    }
}



