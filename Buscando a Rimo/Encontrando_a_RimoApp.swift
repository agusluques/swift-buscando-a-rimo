//
//  Buscando_a_RimoApp.swift
//  Buscando a Rimo
//
//  Created by Agustin Luques on 29/04/2021.
//

import SwiftUI

@main
struct Buscando_a_RimoApp: App {
    var body: some Scene {
        let game = EmojiMemoryGame()
        return WindowGroup {
            EmojiMemoryGameView(emojiMemoryGame: game)
        }
    }
}
