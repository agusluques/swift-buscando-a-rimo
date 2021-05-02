//
//  EmojiMemoryGame.swift
//  Buscando a Rimo
//
//  Created by Agustin Luques on 30/04/2021.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String>?// = EmojiMemoryGame.createMemoryGame()
    
    // MARK: - Game
    func createMemoryGame() {
        selectedTheme = themes[Int.random(in: 0..<themes.count)]
        game = MemoryGame<String>(numberOfPairsOfCrads: selectedTheme!.pairOfCards) { pairIndex in
            selectedTheme!.emojis[pairIndex]
        }
        isGameCreated = true
    }
    
    var isGameCreated = false
        
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        game!.cards
    }
    
    var score: Int {
        game!.score
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        game!.choose(card)
    }
    
    // MARK: - Themes
    private(set) var selectedTheme: Theme?
    
    struct Theme {
        var name: String
        var emojis: Array<String>
        var pairOfCards: Int { emojis.count }
        var color: Color
    }
    
    private var themes = [
        Theme(name: "animals", emojis: ["🐶", "🦊", "🙈", "🐸"], color: .blue),
        Theme(name: "sports", emojis: ["⚽️", "🏈", "🎱", "🏓", "🥎"], color: .blue),
        Theme(name: "common", emojis: ["😁", "👏", "😘", "🤦‍♂️", "😌", "✌️", "🥰", "😱"], color: .blue)
    ]
}
