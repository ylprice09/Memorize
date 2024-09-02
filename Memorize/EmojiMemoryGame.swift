//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Lin Price on 8/19/24.
//

import SwiftUI


//viewmodel
class EmojiMemoryGame: ObservableObject {
    private static let emojis = [
        ["👻","🎃","🕷️","😈","💀","🕸️","🧙🏻‍♀️","🙀","👹","😱","☠️","🍭"],
        ["🐱","🐶","🐯","🐭","🐰","🐷","🦊","🐼","🐵","🐨","🐮","🦋"],
        ["🍎","🍒","🍋","🍑","🥭","🍈","🍏","🍇","🥝","🍌","🍍","🫐"],
        ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓"],
        ["🩷","❤️","💛","🧡","💚","🖤","🩶","🤎","💙","🩵","💜","🤍"],
        ["🧶","🧵","🪡","🧥","👗","👙","👠","🧣","🧤","👑","👛","👒"]
        ]
    
    private static var randomThemeIndex = Int.random(in: 0..<emojis.count)

    static func createMemoryGame() -> MemoryGame<String> {
        
        return MemoryGame(numberOfPairsOfCards: 10, randomThemeIndex: EmojiMemoryGame.randomThemeIndex) { pairIndex in
            if emojis[randomThemeIndex].indices.contains(pairIndex) {
                return EmojiMemoryGame.emojis[randomThemeIndex][pairIndex]
            } else {
                return "⁉️"
            } //access control & trailing closure
        }
    }
    
    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themes: Array<MemoryGame<String>.Theme> {
        return model.themes
    }
    
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        // Generate a new random theme index
        EmojiMemoryGame.randomThemeIndex = Int.random(in: 0..<EmojiMemoryGame.emojis.count)
        
        // Create a new memory game with the new random theme
        model = EmojiMemoryGame.createMemoryGame()
        
    }

    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
