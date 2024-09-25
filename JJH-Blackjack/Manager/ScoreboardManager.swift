//
//  ScoreboardManager.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/25/24.
//

import Foundation

class ScoreboardManager: ObservableObject {
    var turnType: TurnType = .playerTurnOver
    var alertAction: (() -> ())?
    
    func alertMessage(playerScore: Int?, cpuScore: Int?) -> String {
        switch turnType {
        case .playerTurnOver:
            if let score = playerScore {
                return "You scored \(score)"
            }
        case .gameOver:
            if let score = playerScore, let score2 = cpuScore {
                return "You scored \(score), the computer scored \(score2)\n\nYou win!"
            }
        }
        
        return ""
    }
}
