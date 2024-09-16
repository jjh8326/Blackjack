//
//  DrawnCardMapping.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/15/24.
//

import Foundation

class DrawnCardMapping: Identifiable, Hashable {
    static func == (lhs: DrawnCardMapping, rhs: DrawnCardMapping) -> Bool {
        //Not implemented
        return true //lhs.hashValue > rhs.hashValue
    }
    
    //TODO: Why not show up...?
    func hash(into hasher: inout Hasher) {
        hasher.combine(isPlayerCard)
        hasher.combine(card)
    }
    
    var isPlayerCard: Bool
    var card: PlayingCard
    
    init(isPlayerCard: Bool, card: PlayingCard) {
        self.isPlayerCard = isPlayerCard
        self.card = card
    }
}
