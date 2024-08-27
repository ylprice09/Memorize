//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Lin Price on 8/19/24.
//

import Foundation

//model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> // only setting this var is private
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        
        
        var isFaceUp = true
        var isMatched = false
        var content: CardContent // 'don't care'
        
        var id: String
    }
    
}
