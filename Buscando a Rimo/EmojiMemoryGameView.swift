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
                    withAnimation(.easeInOut) {
                        emojiMemoryGame.createMemoryGame()
                    }
                }).font(.title).foregroundColor(.red)
                Grid(emojiMemoryGame.cards) { card in
                        CardView(card: card).onTapGesture {
                            withAnimation(.linear(duration: flipCardDuration)) {
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
    
    // MARK: - Drawing Constants
    private let flipCardDuration: Double = 0.5
}

struct CardView: View  {
    var card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }

    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                                .onAppear {
                                    startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                                .foregroundColor(.yellow);
                        }
                    }.padding(5).opacity(circleOpacity)
                    Text(card.content).font(.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? .linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
            }
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
