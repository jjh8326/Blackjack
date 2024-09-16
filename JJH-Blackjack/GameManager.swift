//
//  GameManager.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/15/24.
//

import Foundation

class GameManager {
    private var deck = CardDeck()
    
//    //TODO: Google comment structure for dict
//    //Int(PlayerCard or not): PlayingCard
//    private var drawnCardList = [DrawnCard?]()
    
    init() {
        beginGame()
    }
    
    func beginGame() {
        //Draw player and CPU cards
        deck.drawCard(isPlayerCard: true)
        deck.drawCard(isPlayerCard: true)
        deck.drawCard(isPlayerCard: false)
        deck.drawCard(isPlayerCard: false)
    }
    
    //Return first four cards drawn
    func playerStartingCards() -> [PlayingCard] {
        return [deck.drawnCardsMapping[0].1, deck.drawnCardsMapping[1].1]
    }
    
    func cpuStartingCards() -> [PlayingCard] {
        return [deck.drawnCardsMapping[2].1, deck.drawnCardsMapping[3].1]
    }
    
    func drawCard(isPlayerCard: Bool) {
        deck.drawCard(isPlayerCard: isPlayerCard)
    }
}
