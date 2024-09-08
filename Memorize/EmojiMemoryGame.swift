//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Lin Price on 8/19/24.
//

import SwiftUI


//viewmodel
class EmojiMemoryGame: ObservableObject {
    private static let themes = [
        MemoryGame<String>.Theme(name:"halloween", emoji: ["👻","🎃","🕷️","😈","💀","🕸️","🧙🏻‍♀️","🙀","👹","😱","☠️","🍭"],
              numOfPairs: 12, color: "orange"),
        MemoryGame<String>.Theme(name: "animal", emoji:["🐱","🐶","🐯","🐭","🐰","🐷","🦊","🐼","🐵","🐨","🐮","🦋"],
              numOfPairs: 12, color: "pink"),
        MemoryGame<String>.Theme(name:"fruit",
              emoji: ["🍎","🍒","🍋","🍑","🥭","🍈","🍏","🍇","🥝","🍌","🍍","🫐"],
              numOfPairs: 12, color: "red"),
        MemoryGame<String>.Theme(name:"sports", emoji:["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓"],
              numOfPairs: 12, color: "blue"),
        MemoryGame<String>.Theme(name:"heart", emoji: ["🩷","❤️","💛","🧡","💚","🖤","🩶","🤎","💙","🩵","💜","🤍"],
              numOfPairs: 12, color: "black"),
        MemoryGame<String>.Theme(name:"fashion", emoji: ["🧶","🧵","🪡","🧥","👗","👙","👠","🧣","🧤","👑","👛","👒"],
              numOfPairs: 12, color: "purple")
        ]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let randomTheme = themes.randomElement()!
        return MemoryGame<String>(numberOfPairsOfCards: randomTheme.numOfPairs, theme: randomTheme) { pairIndex in
            randomTheme.emoji[pairIndex]
        }
    }
    
    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var theme: MemoryGame<String>.Theme {
        model.themes[0] // Assuming the model stores the current theme as the first (and only) element of its themes array
    }

    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }

    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
