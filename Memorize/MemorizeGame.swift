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
    private(set) var themes: Array<Theme>
    
    init(numberOfPairsOfCards: Int, numOfThemes: (Int), cardContentFactory: (Int)  -> CardContent) {
        cards = Array<Card>()
        themes = Array<Theme>()
        
        
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only}
        set { return cards.indices.forEach{cards[$0].isFaceUp = (newValue == $0)}}
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
      
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func newGame() {
        for index in 0..<cards.count {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
    
        var isFaceUp = false
        var isMatched = false
        var content: CardContent // 'don't care'
        
        var id: String
        
        var debugDescription: String {
             "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
    }
    
    struct Theme {
        var name : String
        var emoji : [String]
        var numOfPairs : Int
        var color : String
    }
    
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
