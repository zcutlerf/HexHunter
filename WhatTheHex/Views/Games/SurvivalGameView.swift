//
//  SurvivalGameView.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 4/8/24.
//

import SwiftUI

struct SurvivalGameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var vm: SurvivalGameViewModel = SurvivalGameViewModel()

    var body: some View {
        TimedGameBaseView(vm: vm)
            .alert(vm.gameOverMessage, isPresented: $vm.gameOver) {
                Button("Play again"){ vm.reset() }
                Button("Exit"){ presentationMode.wrappedValue.dismiss() }
            }
            .onAppear{
                vm.reset()
            }
    }
}

#Preview {
    SurvivalGameView(vm: SurvivalGameViewModel(minimumSimilarityToScore: 0.0))
}
