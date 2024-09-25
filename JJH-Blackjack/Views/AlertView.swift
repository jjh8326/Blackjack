//
//  AlertView.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/22/24.
//

import SwiftUI

struct AlertView: View {
    @Binding var show: Bool
    var playerScore = 0
    var gameManager: GameManager?
    
    //TODO: Common code or better spot
    typealias ActionBlock = (() -> ())
    var buttonAction: ActionBlock?
    
    var body: some View {
        //TODO:
        VStack {
            //Color.black.opacity(0.75)
                //.edgesIgnoringSafeArea(.all)
            
            Spacer()
            Text(gameManager?.alertMessage() ?? "")
            Spacer()
            Button("Ok") {
                buttonAction?()
                gameManager?.beginCPUTurn()
            }
            Spacer()
        }
    }
}

//TODO: How to pass binding bool??
//struct AlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlertView()
//    }
//}
