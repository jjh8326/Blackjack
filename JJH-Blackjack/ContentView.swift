//
//  ContentView.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/8/24.
//

import SwiftUI

//TODO: Get images
//♠️ ♦️ ♥️ ♣️

struct ContentView: View {
    
    @ObservedObject private var gameManager = GameManager()
    @State private var showScore = false
    
    var body: some View {
        VStack {
            //Title
            HStack {
                Text("Blackjack")
            }
            Spacer()
            //Dealt cards
            HStack {
                Spacer()
                //Player card area
                VStack {
                    Text("Player")
                        .padding(.bottom, 10)
                    HStack {
                        let playerCards = gameManager.playerStartingCards()
                        Text(playerCards[0].cardName())
                        Text(playerCards[1].cardName())
                    }
                }
                Spacer()
                //CPU card area
                VStack {
                    Text("CPU")
                        .padding(.bottom, 10)
                    HStack {
                        let cpuCards = gameManager.cpuStartingCards()
                        Text(cpuCards[0].cardName())
                        Text(cpuCards[1].cardName())
                    }
                }
                Spacer()
            }
            Spacer()
            //Draw cards & buttons
            HStack {
                HStack {
                    //Drawn cards (1 up to 9)
                    ForEach(gameManager.hitCards, id: \.self) { card in
                        Text(card.cardName())
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        Button("Reset") {
                            gameManager.resetGame()
                        }.padding(.bottom, 10)
                        Button("Hit") {
                            //Update the hit cards
                            gameManager.hitPressed()
                        }.padding(.bottom, 10)
                        Button("Stay") {
                            gameManager.stayPressed()
                            showScore = true
                        }
                    }
                }
            }
        }
        .padding(.top, 10)
        .alert(isPresented: $showScore) {
            Alert(
                title: Text("Score"),
                message: Text(String(gameManager.score))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
