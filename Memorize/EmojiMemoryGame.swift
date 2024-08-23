//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Lin Price on 8/19/24.
//

import SwiftUI

func createCardContent(forPairAtIndex index: Int) -> String {
    return ["👻","🎃","🕷️","😈", "💀", "🕸️", "🧙🏻‍♀️", "🙀", "👹", "😱", "☠️", "🍭"][index]
}
//viewmodel
class EmojiMemoryGame {
    private var model: MemoryGame<String> = MemoryGame(
        numberOfPairsOfCards: 4,
        cardContentFactory: {(index: Int) -> String in
            return ["👻","🎃","🕷️","😈", "💀", "🕸️", "🧙🏻‍♀️", "🙀", "👹", "😱", "☠️", "🍭"][index]
        }
    )//access control
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
