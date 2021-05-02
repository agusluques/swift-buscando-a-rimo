//
//  EmojiMemoryGameView.swift
//  Buscando a Rimo
//
//  Created by Agustin Luques on 29/04/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        if emojiMemoryGame.isGameCreated {
            VStack {
                Text("Encontrando a Rimo")
                HStack {
                    Text("Theme: \(emojiMemoryGame.selectedTheme!.name)")
                    Spacer()
                    Text("Score: \(emojiMemoryGame.score)")
                }.padding()
                Grid(emojiMemoryGame.cards) { card in
                        CardView(card: card).onTapGesture {
                            emojiMemoryGame.choose(card: card)
                        }
                        .padding(5)
                    }
                .foregroundColor(emojiMemoryGame.selectedTheme!.color);
            }
        } else {
            Button("New Game", action: {emojiMemoryGame.createMemoryGame()})
                .font(.largeTitle)
        }
        
    }
}

struct CardView: View  {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke()
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).fill();
                    }
                }
            }
            .font(.system(size: fontSize(for: geometry.size)));
        }
        
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 25.0
    private let fontScaleFactor: CGFloat = 0.75

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
