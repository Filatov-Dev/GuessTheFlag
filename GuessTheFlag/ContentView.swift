//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Filatov Yurii on 12.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia","Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    
    var body: some View{
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)        //придание цвета тексту
                        .padding(15)
                        .font(.title)
                        
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)      //Задание размера шрифта
                        .fontWeight(.black)     //Обводка текста
                }
                
                ForEach(0 ..< 3){number in
                    Button(action:{
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)       //создание рандомных картинок
                            .clipShape(Capsule())       //придание формы флагам
                            .overlay(Capsule().stroke(Color .black, lineWidth: 1))      //Создание обводки вокруг картинки
                            .shadow(color: .black, radius: 2)       //Создание тени вокруг флага
                    }
                    
                }
                
                VStack{
                    Text("You score is: \(score)")
                        .foregroundColor(.white)
                        .padding(35)
                        .font(.subheadline)
                        
                }
                
                
                
                Spacer()
            }
        }
        
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("You score is \(score) point"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
                })
            }
    }
    
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, this is \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
