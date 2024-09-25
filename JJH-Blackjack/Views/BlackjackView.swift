//
//  BlackjackView.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/8/24.
//

import SwiftUI

//TODO: Get images
//♠️ ♦️ ♥️ ♣️

//TODO: App starts in portrait mode

struct BlackjackView: View {
    
    @ObservedObject private var gameManager = GameManager()
    @State var presentAlert = false
    @State var showCPUProgress = false
    
    var body: some View {
        if (presentAlert || gameManager.gameOver) {
            ScoreboardView(show: $presentAlert, gameManager: gameManager, buttonAction: {
                switch gameManager.scoreboardManager.turnType {
                case .playerTurnOver:
                    gameManager.beginCPUTurn()
                    showCPUProgress = true
                    presentAlert.toggle()
                case .gameOver:
                    showCPUProgress = false
                    gameManager.resetGame()
                }
            })
        } else {
            VStack {
                //Title
                HStack {
                    Text("Blackjack")
                }
                
                if (showCPUProgress) {
                    Spacer()
                    Text(gameManager.cpuProgress)
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
                                showCPUProgress = false
                            }.padding(.bottom, 10)
                            Button("Hit") {
                                //Update the hit cards
                                gameManager.hitPressed()
                            }.padding(.bottom, 10)
                            Button("Stay") {
                                //TODO: Rename to calculate cards?
                                gameManager.stayPressed()
                                //Show the alert
                                presentAlert.toggle()
                            }
                        }
                    }
                }
            }
            .padding(.top, 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BlackjackView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
