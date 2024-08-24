//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Lin Price on 8/19/24.
//

import SwiftUI


//viewmodel
class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻","🎃","🕷️","😈", "💀", "🕸️", "🧙🏻‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return EmojiMemoryGame.emojis[pairIndex]
            } else {
                return "⁉️"
            } //access control & trailing closure
        }
    }
    
    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }

    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
