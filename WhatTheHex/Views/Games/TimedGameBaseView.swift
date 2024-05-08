//
//  GameView.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 4/6/24.
//

import SwiftUI

struct TimedGameBaseView: View {
    
    @State var vm: TimedGameViewModel
    
    var squaresView: RotatingView<some View> {
        let g = Group {
            ColorSquareView(title: "Target", hexcode: vm.targetHexcode, showingCode: vm.gameOver)
            ColorSquareView(title: "Your guess", hexcode: vm.playerHexcode, showingCode: true)
        }
        return RotatingView(content: g, originalOrientation: .horizontal)
    }

    var guessButton: some View {
        Button("Guess"){
            vm.submitGuess()
        }
        .buttonStyle(GameSelectionButton())
    }
    var body: some View {
        
        GeometryReader{ geo in
            if geo.size.height > geo.size.width {
                VStack{
                    TimerView(vm: vm)
                    squaresView.original
                    RGBSlidersView(hexcode: $vm.playerHexcode)
                    guessButton
                }
            } else {
                HStack{
                    squaresView.flipped
                    RGBSlidersView(hexcode: $vm.playerHexcode)
                    VStack{
                        Spacer()
                        TimerView(vm: vm)
                        Spacer()
                        guessButton
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .onAppear{
            AudioPlayer.shared.startBackgroundLoop(sound: vm.audioFileName, type: "mp3")
        }
        .onDisappear{
            AudioPlayer.shared.stopBackgroundSound()
        }
    }
}

#Preview {
    TimedGameBaseView(vm: SurvivalGameViewModel())
}
