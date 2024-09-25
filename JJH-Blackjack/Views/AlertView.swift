//
//  AlertView.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/22/24.
//

import SwiftUI

public struct AlertView: View {
    @Binding var show: Bool
    var playerScore = 0
    var gameManager: GameManager?
    var buttonAction: (() -> ())?
    
    public var body: some View {
        VStack {
            //TODO: Design?
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

//TODO: How to pass binding bool - need wrapper view
//struct AlertView_Previews: PreviewProvider {
//    @State var showAlert: Bool = false
//    static var previews: some View {
//        AlertView(show: $showAlert)
//    }
//}
