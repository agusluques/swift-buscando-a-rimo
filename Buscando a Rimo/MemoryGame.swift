//
//  MemoryGame.swift
//  Buscando a Rimo
//
//  Created by Agustin Luques on 30/04/2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    private var visitedIndices = Set<Int>()
    
    private var indexOfSelectedCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCrads: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCrads {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
        
        cards.shuffle()
    }

    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfSelectedCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += matchingScore
                } else {
                    if visitedIndices.contains(chosenIndex) {
                        score += nonMatchingScore
                    }
                    if visitedIndices.contains(potentialMatchIndex) {
                        score += nonMatchingScore
                    }
                }
                cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
                visitedIndices.insert(potentialMatchIndex)
                visitedIndices.insert(chosenIndex)
            } else {
                indexOfSelectedCard = chosenIndex
            }
        }
    }

    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
    
    // MARK: -Score Constants
    private let matchingScore = 2
    private let nonMatchingScore = -1
}


