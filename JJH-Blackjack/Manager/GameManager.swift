//
//  GameManager.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/15/24.
//

import Foundation

class GameManager: ObservableObject {
    private var deck = CardDeck()
    
    //TODO: Rename to scoreboard - its not an alert
    var alertManager = AlertManager()
    
    //Make these available for the view to consume
    @Published var hitCards = [PlayingCard]()
    @Published var gameOver: Bool = false

    //TODO: May need to make object that holds score data
    @Published var playerScore = 0
    @Published var cpuScore = 0
    
    public var cpuProgress = ""

    init() {
        beginGame()
    }
    
    func alertMessage() -> String {
        return alertManager.alertMessage(playerScore: playerScore, cpuScore: cpuScore)
    }
    
    //TODO: Organize methods by manager they control
    
    func resetGame() {
        deck = CardDeck()
        hitCards = []
        alertManager = AlertManager()
        gameOver = false
        beginGame()
    }
    
    //TODO: Need to one card flipped for CPU
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
    }
    
    func beginCPUTurn() {
        //Game is over but CPU needs to take turn
        alertManager.alertType = .gameOver
        
        //Update CPU progress
        let random = Bool.random()
        
        if random {
            cpuProgress = "CPU decides to hit"
            //TODO: Weak self?
            //while (needs to hit)
            _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
                //TODO: Hit pressed needs to take player card arg
                self.hitPressed()
                
                //TODO: Refactor
                _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
                    self.gameOver = true
                }
            }
        } else {
            cpuProgress = "CPU decides to stay"
            _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
                //self.showFinalScore
                
                //TODO: Refactor
                _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
                    self.gameOver = true
                }
            }
        }
        
        //TODO: OLD NOTES BELOW
        
            //TODO: show player score next to "player"
            
            //TODO: show new status bar in between black jacks and initial cards
            
            //TODO: display CPU hit / stay intentions
            //hitPressed()
            
            //TODO: animate hits if needed
            
            //TODO: show final score board
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
        
        //Test case: [Ace, Eight]
        
        //TODO: This logic is meh...
        //Calculate if no need for ace swap
        if aces > 0 {
            var tempTotal = total
            
            for _ in 1...aces {
                tempTotal += 11
            }
            
            if (tempTotal != 21) {
                //TODO: Define!
                //(Stop swapping, (Total, Number of aces))
                var swapCheck = (false,(tempTotal, aces))
                
                while (swapCheck.0 == false) {
                    swapCheck = calculateForAceSwap(currentTotal: swapCheck.1.0, unswappedAcesCount: swapCheck.1.1)
                }
                
                playerScore = swapCheck.1.0
            } else {
                playerScore = tempTotal
            }
        } else {
            playerScore = total
        }
    }
    
    func calculateForAceSwap(currentTotal: Int, unswappedAcesCount: Int) -> (Bool, (Int, Int)) {
        if (unswappedAcesCount == 0) {
            //Don't swap, nothing left to swap
            return (true, (currentTotal,unswappedAcesCount))
        }
        
        var newTotal = currentTotal - 11
        //Swap one of the aces for a 1
        newTotal += 1
        
        if (currentTotal < 21 && newTotal < currentTotal) {
            //Don't swap
            return (true, (currentTotal,unswappedAcesCount - 1))
        }
        
        //Swap
        return (false, (newTotal,unswappedAcesCount - 1))
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
