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
    
    @State private var deck = CardDeck()
    @State private var drawnCards = [PlayingCard]()
    
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
                        //Card 1
                        Text("A♥️")
                            .padding(.trailing, 10)
                        //Card 2
                        Text("2♣️")
                    }
                }
                Spacer()
                //CPU card area
                VStack {
                    Text("CPU")
                        .padding(.bottom, 10)
                    HStack {
                        //Card 1
                        Text("5♠️")
                            .padding(.trailing, 10)
                        //Card 2
                        Text("Q♦️")
                    }
                }
                Spacer()
            }
            Spacer()
            //Draw cards & buttons
            HStack {
                HStack {
                    //Drawn cards (1 up to 9)
                    ForEach(drawnCards, id: \.self) { card in
                        Text(card.cardName())
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        Button("Hit") {
                            if let card = deck.drawCard() {
                                drawnCards.append(card)
                            }
                        }.padding(.bottom, 10)
                        Button("Stay") {
                            //
                        }
                    }
                }
            }
        }.padding(.top, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
