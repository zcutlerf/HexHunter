//
//  RapidGameViewModel.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 4/6/24.
//

import Foundation
import Combine

@Observable
class RapidGameViewModel: TimedGameViewModel {
    
    var targetHexcode: Hexcode = Hexcode.random()
    var playerHexcode: Hexcode = Hexcode()
    
    var guesses: [Guess] = []
    
    var timer = Timer.publish(every: 1, on: .main, in: .common)
    var timerSubscription: Cancellable?
    var gameOver: Bool = false
    let gameTimeMax: Int
    var timeRemaining: Int
    var bonusTimeAnimationTrigger: Bool = false
    var audioFileName: String = "GameplayLoop"
    
    var minimumSimilarityToScore: Double
    
    var showingAlert = false
    
    init(gameTimeMax: Int = 90, scoringSimilarity: Double = 80) {
        self.gameTimeMax = gameTimeMax
        self.timeRemaining = gameTimeMax
        self.minimumSimilarityToScore = scoringSimilarity
        self.timerSubscription = timer.connect()
    }
    
    func submitGuess() {
        guesses.append(Guess(playerGuess: playerHexcode, target: targetHexcode))
        playerHexcode = Hexcode()
        targetHexcode = Hexcode.random()
    }
    
    /// resets the game and starts timer
    func reset() {
        guesses.removeAll()
        targetHexcode = Hexcode.random()
        playerHexcode = Hexcode()
        timeRemaining = gameTimeMax
        timer = Timer.publish(every: 1, on: .main, in: .common)
        timerSubscription = timer.connect()
    }
    
    func calculateScore() -> Double {
        Double(guesses.filter{ $0.similarityScore > minimumSimilarityToScore }.count)
    }
    
}


#if DEBUG
extension RapidGameViewModel {
    static var sample: RapidGameViewModel {
        let vm = RapidGameViewModel(gameTimeMax: 5)
        vm.guesses = [Guess(playerGuess: Hexcode.random(), target: Hexcode()), Guess(playerGuess: Hexcode.teal, target: Hexcode.teal)]
        return vm
    }
}
#endif
