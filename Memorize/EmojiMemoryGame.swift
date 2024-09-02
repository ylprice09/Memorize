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
    
    static func createMemoryGame() -> MemoryGame<String> {
        let themeRange = 0..<6
        let randomThemeIndex = Int.random(in: themeRange)
        
        return MemoryGame(numberOfPairsOfCards: 10, randomThemeIndex: randomThemeIndex) { pairIndex in
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
        model.newGame()
    }

    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
