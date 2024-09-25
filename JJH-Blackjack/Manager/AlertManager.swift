//
//  AlertManager.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/25/24.
//

import Foundation

class AlertManager: ObservableObject {
    var alertType: AlertType = .playerTurnOver
    var alertAction: (() -> ())?
    
    func alertMessage(playerScore: Int?, cpuScore: Int?) -> String {
        switch alertType {
        case .playerTurnOver:
            if let score = playerScore {
                return "You scored \(score)"
            }
        case .gameOver:
            return "Game over"
        }
        
        return ""
    }
}
