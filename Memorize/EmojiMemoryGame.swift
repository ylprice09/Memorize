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
        let numOfThemes = 6
        let themeRange = 0..<numOfThemes
        
        return MemoryGame(numberOfPairsOfCards: 10, numOfThemes: numOfThemes) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                let randomThemeIndex = Int.random(in: themeRange)
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
