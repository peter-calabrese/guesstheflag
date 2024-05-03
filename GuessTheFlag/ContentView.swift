//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Peter Calabrese on 4/27/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var addBorder = false
  @State private var showingScore = false
  @State private var selectedFlag = ""
  @State private var gameTitle = "Guess the Flag"
  @State private var gameOver = false
  @State private var score = 0
  @State private var timeRemaining = 5
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  var body: some View {
    ZStack{
      RadialGradient(stops:[
        .init(color: Color(red:0.1,green: 0.2, blue:0.45), location: 0.3),
        .init(color: Color(red:0.76,green: 0.15, blue:0.3), location: 0.3)
      ] ,center: .top, startRadius: 200, endRadius: 700)
      .ignoresSafeArea()
      VStack{
        Spacer()
        Text(gameTitle)
          .font(.largeTitle.weight(.bold))
          .foregroundStyle(.white)
        VStack(spacing:15) {
          VStack {
            Text(gameOver ? "You selected" : "Tap the flag of")
              .font(.subheadline.weight(.heavy))
              .foregroundStyle(.secondary)
            Text(!gameOver ? countries[correctAnswer] : selectedFlag)
              .foregroundStyle(.secondary)
              .font(.largeTitle.weight(.semibold))
          }
          ForEach(0..<3){number in
            Button{
              flagTapped(number)
            } label: {
              Image(countries[number])
                .overlay(gameOver ? RoundedRectangle(cornerRadius: 10).stroke(number == correctAnswer ? Color.green : Color.red, lineWidth: 5): nil)
                .shadow(radius: 5)
                .clipShape(.rect(cornerRadius: 5))
                
            }
            .disabled(gameOver)
          }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
      
        Spacer()
        Spacer()
        Text("Score \(score)")
          .foregroundStyle(.white)
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
       gameOver ? 
        Button("Restart", role: .cancel, action: newGame)
          .padding()
          .foregroundColor(.white)
          .background(.indigo)
          .clipShape(.rect(cornerRadius: 10))
        : Button("", action:{})
          .padding()
          .foregroundColor(.white)
          .background(.clear)
          .clipShape(.rect(cornerRadius: 10))
        Spacer()
      }
      .padding()
      
    }
  }
  func flagTapped(_ number: Int){
    if number == correctAnswer {
      score += 1
      askQuestion()
    } else{
      selectedFlag = countries[number]
      gameOver = true
      gameTitle = "Game Over"
    }

  }
  
  func askQuestion() {
    
    countries.shuffle()
    correctAnswer = Int.random(in:0...2)

  }
  
  func newGame() {
    gameOver = false
    score = 0
    gameTitle = "Guess the Flag"
    askQuestion()
  }
  
  func getFlagSelected(_ number: Int) -> String {countries[number]}
}

#Preview {
  ContentView()
}
