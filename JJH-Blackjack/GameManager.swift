//
//  GameManager.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/15/24.
//

import Foundation

class GameManager: ObservableObject {
    private var deck = CardDeck()
    
    //Make these available for the view to consume
    @Published var hitCards = [PlayingCard]()
    @Published var showScore = false

    //TODO: May need to make object that holds score data
    @Published var score = 0

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

        var total = 0
        var aces = 0
        
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
        
        //[Ace, Eight] fails here and calculates as 8
        
        //TODO: This logic is meh...
        //Calculate if no need for ace swap
        if aces > 0 {
            var tempTotal = total
            
            for _ in 1...aces {
                tempTotal += 11
            }
            
            if (tempTotal != 21) {
                //TODO: Define!
                //((Stop swapping, swappedTimes), (Total, Number of aces))
                var swapCheck = ((false, 0),(tempTotal, aces))
                
                while (swapCheck.0.0 == false) {
                    swapCheck = calculateForAceSwap(currentTotal: swapCheck.1.0, unswappedAcesCount: swapCheck.1.1, swappedTimes: swapCheck.0.1)
                }
                
                score = swapCheck.1.0
            } else {
                score = tempTotal
            }
        } else {
            score = total
        }
    }
    
    func calculateForAceSwap(currentTotal: Int, unswappedAcesCount: Int, swappedTimes: Int) -> ((Bool, Int), (Int, Int)) {
        if (unswappedAcesCount == swappedTimes) || (unswappedAcesCount == 0) {
            return ((true, swappedTimes), (currentTotal,unswappedAcesCount))
        }
        
        //Swap one of the aces for a 1
        var newTotal = currentTotal - 11
        newTotal += 1
        
        if (currentTotal < 21 && newTotal < currentTotal) {
            //Don't swap
            return ((true, swappedTimes - 1), (currentTotal,unswappedAcesCount - 1))
        }
        
//        if (newTotal <= 21 && currentTotal <= 21 && newTotal < currentTotal) {
//            return ((true, swappedTimes - 1), (currentTotal,unswappedAcesCount - 1))
//        }
        
//       //TODO: NEED TO CALCULATE WHEN TO STOP SWAPPING ACES (is this correct?)
//        if (newTotal <= 21) {
//            return ((true, swappedTimes + 1), (newTotal,unswappedAcesCount - 1))
//        } else
        
        return ((false, swappedTimes + 1), (newTotal,unswappedAcesCount - 1))
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
