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
                Text("Theme: \(emojiMemoryGame.selectedTheme!.name)")
                Button("Reset Game", action: {
                    withAnimation(.easeInOut(duration: 1)) {
                        emojiMemoryGame.createMemoryGame()
                    }
                }).font(.title).foregroundColor(.red)
                Grid(emojiMemoryGame.cards) { card in
                        CardView(card: card).onTapGesture {
                            withAnimation(.linear(duration: 1)) {
                                emojiMemoryGame.choose(card: card)
                            }
                        }
                        .padding(5)
                    }
                Text("Score: \(emojiMemoryGame.score)")
            }
                .font(.largeTitle)
                .foregroundColor(emojiMemoryGame.selectedTheme!.color);
        } else {
            Button("New Game", action: {emojiMemoryGame.createMemoryGame()})
                .font(.largeTitle)
        }
        
    }
}

struct CardView: View  {
    var card: MemoryGame<String>.Card

    var body: some View {
        if card.isFaceUp || !card.isMatched {
            GeometryReader { geometry in
                ZStack {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockwise: true).padding(5).opacity(circleOpacity)
                    Text(card.content).font(.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? .linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
            }.transition(.scale)
        }
    }
    
    // MARK: - Drawing Constants
    private let fontScaleFactor: CGFloat = 0.7
    private let circleOpacity: Double = 0.4

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.createMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(emojiMemoryGame: game)
    }
}
