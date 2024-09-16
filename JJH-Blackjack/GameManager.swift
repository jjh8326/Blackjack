//
//  GameManager.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/15/24.
//

import Foundation

class GameManager: ObservableObject {
    private var deck = CardDeck()
    //Make it available for the view to consume
    @Published var hitCards = [PlayingCard]()
    
    init() {
        beginGame()
    }
    
    func resetGame() {
        //TODO:
    }
    
    func beginGame() {
        //Draw player and CPU cards
        deck.drawCard(isPlayerCard: true)
        deck.drawCard(isPlayerCard: true)
        deck.drawCard(isPlayerCard: false)
        deck.drawCard(isPlayerCard: false)
    }
    
    func hitPressed() {
        drawCard(isPlayerCard: true)
        let drawnCardsMapping = deck.drawnCardsMapping
        let lastCardDrawnMapping = drawnCardsMapping[drawnCardsMapping.count - 1]
        hitCards.append(lastCardDrawnMapping.card)
    }
    
    func stayPressed() {
        calculatePlayerCards()
        //beginCPUTurn()
    }
    
    func calculatePlayerCards() {
        //TODO: Determine if player bust
        //if calculateCardValue() < 21 { bust }
        
        //TODO: Move below into own method
        
        var total = 0
        var aces = 0
        
        //TODO: Move this logic
        for card in playerCards() {
            switch card.cardValue {
            case .two:
                total += 2
            case .three:
                total += 3
            case .four:
                total += 4
            case .five:
                total += 5
            case .six:
                total += 6
            case .seven:
                total += 7
            case .eight:
                total += 8
            case .nine:
                total += 9
            case .ten:
                total += 10
            case .jack:
                total += 10
            case .queen:
                total += 10
            case .king:
                total += 10
            case .ace:
                aces += 1
            case .none:
                total += 0
            }
        }
        
        var tempTotal = total
        
        //Calculate if no need for ace swap
        for _ in 1...aces {
            tempTotal += 11
        }
        
        if (tempTotal != 21) {
            //TODO: Define!
            //((Keep swapping, swappedTimes), (Total, Number of aces))
            var swapCheck = ((false, 0),(tempTotal, aces))
            
            while (swapCheck.0.0 == false) {
                swapCheck = calculateForSwap(currentTotal: swapCheck.1.0, acesCount: swapCheck.1.1, swappedTimes: swapCheck.0.1)
            }
            
            print("here")
        }
    }
    
    func calculateForSwap(currentTotal: Int, acesCount: Int, swappedTimes: Int) -> ((Bool, Int), (Int, Int)) {
        if (acesCount == swappedTimes) || (acesCount == 0) {
            return ((true, swappedTimes), (currentTotal,acesCount))
        }
        
        //Swap one of the aces for a 1
        var newTotal = currentTotal - 11
        newTotal += 1
        
       //TODO: NEED TO CALCUALTE WHEN TO STOP SWAPPING ACES
        
        return ((false, swappedTimes + 1), (currentTotal,acesCount - 1))
    }
    
    func playerCards() -> [PlayingCard] {
        var playerCards = playerStartingCards()
        for card in hitCards {
            playerCards.append(card)
        }
        return playerCards
    }
    
    //Return first four cards drawn
    func playerStartingCards() -> [PlayingCard] {
        return [deck.drawnCardsMapping[0].card, deck.drawnCardsMapping[1].card]
    }
    
    func cpuStartingCards() -> [PlayingCard] {
        return [deck.drawnCardsMapping[2].card, deck.drawnCardsMapping[3].card]
    }
    
    func drawCard(isPlayerCard: Bool) {
        deck.drawCard(isPlayerCard: isPlayerCard)
    }
}
