//
//  ColorOfTheDayViewModel.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 4/10/24.
//

import Foundation

class ColorOfTheDayViewModel: AccuracyGameViewModel {
    
    private let service: ColorOfDayService
    
    init(service: ColorOfDayService) {
        self.service = service
    }
    
    func getHexcodeOfDay() async {
        
        do {
            let colorOfTheDay: String = try await service.fetchColorOfDay(for: NSDate())
            guard let hexcode = Hexcode(from: colorOfTheDay) else { return }
            targetHexcode = hexcode
        } catch {
            print("\(error.localizedDescription)")
        }
        
    }
    
    override func submitGuess() {
        // TODO: record completed daily challenge
        gameOver = true
    }
}
