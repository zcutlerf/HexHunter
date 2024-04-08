//
//  SurvivalGameViewModel.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 4/8/24.
//

import Foundation
import Combine

@Observable
class SurvivalGameViewModel: TimedGameViewModel {
    
    var targetHexcode: Hexcode = Hexcode.random()
    var playerHexcode: Hexcode = Hexcode()
    
    var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    var timerSubscription: Cancellable?
    var gameTimeMax: Int
    var timeRemaining: Int
    var correctGuesses = 0
    
    var minimumSimilarityToScore: Double = 80
    var timeReward: Int = 10
    
    var gameOver: Bool = false
    
    var gameOverMessage: String {
        """
        Score: \(String(format: "%.2f", calculateScore()))
        """
    }
    
    init(gameTimeMax: Int = 30){
        self.gameTimeMax = gameTimeMax
        self.timeRemaining = gameTimeMax
        self.timerSubscription = timer.connect()
    }
    
    func correctGuess() {
        correctGuesses += 1
        timeRemaining += timeReward
    }
    
    func submitGuess() {
        timeRemaining -= 1
        let score = playerHexcode.calculateSimilarity(to: targetHexcode)
        if score > minimumSimilarityToScore {
            correctGuess()
        }
        targetHexcode = Hexcode.random()
        playerHexcode = Hexcode()
    }
    
    func reset() {
        gameOver = false
        correctGuesses = 0
        timeRemaining = gameTimeMax
        targetHexcode = Hexcode.random()
        playerHexcode = Hexcode()
        timer = Timer.publish(every: 1, on: .main, in: .common)
        timerSubscription = timer.connect()
    }
    
    func calculateScore() -> Double {
        return Double(correctGuesses)
    }
    
    
}