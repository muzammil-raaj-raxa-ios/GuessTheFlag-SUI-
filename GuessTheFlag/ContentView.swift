//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mag isb-10 on 04/10/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var score = 0
  @State private var currentQuestion = 1
  @State private var totalQuestions = 8
  @State private var gameOver = false
  
  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
      ], center: .top, startRadius: 200, endRadius: 700)
      .ignoresSafeArea()
      
      VStack {
        Spacer()
        
        Text("Guess the flag")
          .font(.largeTitle.bold())
          .foregroundStyle(.white)
        
        VStack (spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .foregroundStyle(.secondary)
              .font(.subheadline.weight(.heavy))
            
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
          }
          
          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            } label: {
              Image(countries[number])
                .clipShape(.capsule)
                .shadow(radius: 5)
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
        
        Spacer()
        Spacer()
        
        Text("Score: \(score)")
          .foregroundStyle(.white)
          .font(.title.bold())
        
        Spacer()
      }
      .padding()
      
    } .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestions)
    } message: {
      Text("Your score is \(score)")
    }
    .alert("Game over", isPresented: $gameOver) {
      Button("Restart", action: resetGame)
    } message: {
      Text("Your final score is \(score)")
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      score += 1
    } else {
      scoreTitle = "Wrong! That's the flag of \(countries[number])."
    }

    currentQuestion += 1
    
    if currentQuestion == totalQuestions {
      gameOver = true
    } else {
      showingScore = true
    }
    
    print(currentQuestion)
    
  }
  
  func askQuestions() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
  
  func resetGame() {
    score = 0
    currentQuestion = 0
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    gameOver = false
  }
  
}

//#Preview {
//    ContentView()
//}
