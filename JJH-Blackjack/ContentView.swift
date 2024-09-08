//
//  ContentView.swift
//  JJH-Blackjack
//
//  Created by Joe H on 9/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            //Title
            HStack {
                Text("Blackjack")
            }
            Spacer()
            //Dealt cards
            HStack {
                Spacer()
                //Player card area
                VStack {
                    Text("Player")
                        .padding(.bottom, 10)
                    HStack {
                        //Card 1
                        Text("C1")
                            .padding(.trailing, 10)
                        //Card 2
                        Text("C2")
                    }
                }
                Spacer()
                //CPU card area
                VStack {
                    Text("CPU")
                        .padding(.bottom, 10)
                    HStack {
                        //Card 1
                        Text("C1")
                            .padding(.trailing, 10)
                        //Card 2
                        Text("C2")
                    }
                }
                Spacer()
            }
            Spacer()
            //Draw cards & buttons
            HStack {
                HStack {
                    //Draw cards
                    Text("H1")
                        .padding(.trailing, 10)
                    Text("H2")
                        .padding(.trailing, 10)
                    Text("H3")
                        .padding(.trailing, 10)
                    Text("H4")
                        .padding(.trailing, 10)
                    Text("H5")
                        .padding(.trailing, 10)
                    Text("H6")
                        .padding(.trailing, 10)
                    Text("H7")
                        .padding(.trailing, 10)
                    Text("H8")
                        .padding(.trailing, 10)
                    Text("H9")
                }
                Spacer()
                HStack {
                    VStack {
                        Button("Hit") {
                            //
                        }.padding(.bottom, 10)
                        Button("Stay") {
                            //
                        }
                    }
                }
            }
        }.padding(.top, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
