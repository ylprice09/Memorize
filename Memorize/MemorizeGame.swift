//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Lin Price on 8/19/24.
//

import Foundation

//model
struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card> // only setting this var is private
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent // 'don't care'
    }
    
}
