//
//  ScoreboardView.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/22/24.
//

import SwiftUI

public struct ScoreboardView: View {
    @Binding var show: Bool
    var gameManager: GameManager?
    var buttonAction: (() -> ())?
    
    public var body: some View {
        VStack {
            //Title
            HStack {
                Text("Blackjack")
            }
            Spacer()
            
            //TODO: Design?
            //Color.black.opacity(0.75)
                //.edgesIgnoringSafeArea(.all)
            
            Spacer()
            Text(gameManager?.scoreboardMessage() ?? "")
            Spacer()
            //TODO: Make text say reset at game end...
            //TODO: Make cpu card flip upside down
            //TODO: CHECK OTHER TODOS
            //TODO: CPU LOGIC - cleanup first
            Button("Ok") {
                buttonAction?()
            }
            Spacer()
        }.padding(.top, 10)
    }
}

//TODO: How to pass binding bool - need wrapper view
//struct AlertView_Previews: PreviewProvider {
//    @State var showAlert: Bool = false
//    static var previews: some View {
//        AlertView(show: $showAlert)
//    }
//}
