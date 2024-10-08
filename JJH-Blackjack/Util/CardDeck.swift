//
//  CardDeck.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/8/24.
//

import Foundation

//https://gist.github.com/markjamesm/08bf727b1113d4989e59f7073697dc17

enum CardSuit: String, CaseIterable {
    case hearts = "hearts"
    case clubs = "clubs"
    case diamonds = "diamons"
    case spades = "spades"
}

enum CardValue: Int, CaseIterable {
    case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
}

struct PlayingCard: Hashable {
    
    var cardValue: CardValue?
    var cardSuit: CardSuit?
    
    init(value: CardValue?, suit: CardSuit?) {
        self.cardValue = value
        self.cardSuit = suit
    }
    
    func cardName() -> String {
        var cardValueString = ""
        switch cardValue {
        case .two:
            cardValueString = "2"
        case .three:
            cardValueString = "3"
        case .four:
            cardValueString = "4"
        case .five:
            cardValueString = "5"
        case .six:
            cardValueString = "6"
        case .seven:
            cardValueString = "7"
        case .eight:
            cardValueString = "8"
        case .nine:
            cardValueString = "9"
        case .ten:
            cardValueString = "10"
        case .jack:
            cardValueString = "J"
        case .queen:
            cardValueString = "Q"
        case .king:
            cardValueString =  "K"
        case .ace:
            cardValueString = "A"
        case .none:
            cardValueString = ""
        }
        
        var cardSuitEmoji = ""
        switch cardSuit {
        case .hearts:
            cardSuitEmoji = "♥️"
        case .clubs:
            cardSuitEmoji = "♣️"
        case .diamonds:
            cardSuitEmoji = "♦️"
        case .spades:
            cardSuitEmoji = "♠️"
        case .none:
            cardSuitEmoji = ""
        }
        
        return ("\(cardValueString)\(cardSuitEmoji)")
    }
}

class CardDeck {
    
    var cardsRemaining: Int
    var deck: [PlayingCard]
    var drawnCardsMapping: [DrawnCardMapping]
    
    init() {
        cardsRemaining = 52
        deck = []
        drawnCardsMapping = []
        
        //Get the game ready
        createDeck()
        shuffleDeck()
        
        print("Card deck initialized")
    }
    
    func createDeck() {
        for suit in CardSuit.allCases {
            for value in CardValue.allCases {
                deck.append(PlayingCard(value: value, suit: suit))
            }
        }
    }
    
    func listDeck() {
        var count = 0
        
        for card in deck {
            print(card)
            count += 1
        }
        print(count)
    }
    
    func shuffleDeck() {
        deck.shuffle()
    }
    
    func drawCard(isPlayerCard: Bool) {
        guard let cardDrawn = deck.popLast() else {
            print("No cards left in deck!")
            return
        }
        
        if self.cardsRemaining >= 1 {
            self.cardsRemaining -= 1
            
            print("Card drawn: ", cardDrawn.cardName())
            print("Cards remaining: ", cardsRemaining)
            
            //Add card to mapping
            drawnCardsMapping.append(DrawnCardMapping(isPlayerCard: isPlayerCard, card: cardDrawn))
        }
        else {
            print("No cards left in deck!")
        }
    }
}
