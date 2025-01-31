//
//  GameModeButtonView.swift
//  WhatTheHex
//
//  Created by Tyler Lawrence1 on 4/6/24.
//

import SwiftUI

struct GameModeButtonView: View {

    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    let title: String
    var streak: Int? = nil
    
    var frameHeight: CGFloat {
        if dynamicTypeSize.isAccessibilitySize {
            return 150
        } else {
            return 50
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(title)
                    .font(.title)
                    .bold()
                Spacer()
                if let streak {
                    Text("\(streak)")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            Image("streakIcon")
                                .resizable()
                                .scaledToFit()
                        )
                }
            }
        }
        .frame(height: frameHeight)
        .padding()
    }
}

#Preview {
    NavigationStack{
        NavigationLink{
            Text("test")
        } label: {
            GameModeButtonView(title: "Color of the Day", streak: 5)
        }
        
        NavigationLink{
            Text("test")
        } label: {
            GameModeButtonView(title: "Rapid")
        }
    }
    .buttonStyle(.borderedProminent)
}
