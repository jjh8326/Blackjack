//
//  GameManager.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/15/24.
//

import Foundation

class GameManager: ObservableObject {
    private var deck = CardDeck()
    var scoreboardManager = ScoreboardManager()
    
    var timers = [Timer]()
    
    //Make these available for the view to consume
    @Published var playerHitCards = [PlayingCard]()
    @Published var cpuHitCards = [PlayingCard]()
    
    @Published var gameOver: Bool = false

    //TODO: May need to make object that holds score data
    @Published var playerScore = 0
    @Published var cpuScore = 0
    
    public var cpuProgress = ""

    init() {
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
    
    //MARK: Button actions
    
    func resetGame() {
        //TODO: Stop all timers?
        for timer in timers {
            timer.invalidate()
        }
        
        timers = []
        
        deck = CardDeck()
        playerHitCards = []
        cpuHitCards = []
        scoreboardManager = ScoreboardManager()
        gameOver = false
        beginGame()
    }
    
    //TODO: Player type enum
    func hitPressed(playerTurn: Bool) {
        if playerTurn {
            drawCard(isPlayerCard: true)
            let drawnCardsMapping = deck.drawnCardsMapping
            let lastCardDrawnMapping = drawnCardsMapping[drawnCardsMapping.count - 1]
            playerHitCards.append(lastCardDrawnMapping.card)
        } else {
            //TODO: Fix this, draw card should draw a card
            drawCard(isPlayerCard: false)
            let drawnCardsMapping = deck.drawnCardsMapping
            let lastCardDrawnMapping = drawnCardsMapping[drawnCardsMapping.count - 1]
            cpuHitCards.append(lastCardDrawnMapping.card)
        }
    }
    
    func stayPressed() {
        playerScore = calculate(cards: playerCards())
    }
    
    //MARK: Game flow methods
    
    //TODO: Clean this up
    func beginCPUTurn() {
        //Game is over but CPU needs to take turn
        scoreboardManager.turnType = .gameOver
        
        //Update CPU progress
        //let random = Bool.random()
        
        //TODO: NULLIFY ALL TIMERS IF RESET IT HIT - need to save them all
        //TODO: WIP REFACTOR
        
        //TODO: Weak self?
        if shouldCPUHit() {
            cpuProgress = "CPU decides to hit"

            //Visually clear the player hit cards to make way for CPU hit(s)
            self.playerHitCards = []
            
            let timer = createTimerForCPUHit()
            //self.timers.append(timer)
            
            //TODO: Happens too fast - make timers work again
            
            //Check for subsequent hits
            while shouldCPUHit() {
                self.hitPressed(playerTurn: false)
//
//                let timer = createTimerForCPUHit()
//                self.timers.append(timer)
            }
            
            self.gameOver = true
            
        } else {
            cpuProgress = "CPU decides to stay"
            let timer4 = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer4 in
                self.timers.append(timer4)
                
                //self.showFinalScore
                
                //TODO: Refactor
                let timer5 = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer5 in
                    self.timers.append(timer5)
                    self.gameOver = true
                }
            }
            //TODO: Clean up timer logic
            timers.append(timer4)
        }
        
        //TODO: OLD NOTES BELOW
        
        //TODO: show player score next to "player"
            
        //TODO: show new status bar in between black jacks and initial cards
            
        //TODO: display CPU hit / stay intentions
        //hitPressed()
            
        //TODO: animate hits if needed
            
        //TODO: show final score board
    }
    
    func createTimerForCPUHit() -> Timer {
        let timer1 = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer1 in
            //self.timers.append(timer1)
            
            //TODO: Refactor
            let timer2 = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer2 in
                self.timers.append(timer2)
                //self.hitPressed(playerTurn: false)
                //TODO: Must be a better way - game takes a while if no hit cards and then CPU hits...
                let timer3 = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer3 in
                    self.timers.append(timer3)
                    
//                    if self.shouldCPUHit() {
//                        //TODO: Look
//                    } else {
//                        self.gameOver = true
//                    }
                }
            }
        }
        
        return timer1
    }
    
    //TODO: Everything in this method will be printed twice because this method is used to check for hit and for the while loop
    func shouldCPUHit() -> Bool {
        
        //TODO: Consider hitting on soft 17 or lower
        
        cpuScore = calculate(cards: cpuCards())
        print("CPU Score = %@", cpuScore)
        
        //Dealer hits 16 or below
        if (cpuScore <= 16) {
            print("CPU will be hitting!")
            return true
        }
        
        return false
    }
    
    func calculate(cards: [PlayingCard]) -> Int {
        //TODO: Determine if player bust
        //if calculateCardValue() < 21 { bust }

        var total = 0
        var aces = 0
        
        for card in cards {
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
                
                return swapCheck.1.0
            } else {
                return tempTotal
            }
        } else {
            return total
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
    
    //MARK: Deck methods
    
    func playerCards() -> [PlayingCard] {
        var playerCards = playerStartingCards()
        for card in playerHitCards {
            playerCards.append(card)
        }
        return playerCards
    }
    
    func cpuCards() -> [PlayingCard] {
        var cpuCards = cpuStartingCards()
        for card in cpuHitCards {
            cpuCards.append(card)
        }
        return cpuCards
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
    
    //MARK: Scoreboard methods
    
    func scoreboardMessage() -> String {
        return scoreboardManager.alertMessage(playerScore: playerScore, cpuScore: cpuScore)
    }
}
