//
//  ContentView.swift
//  Memorize
//
//  Created by Lin Price on 8/12/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    @State var emojis: [String:Array] = [
        "halloween": ["👻","🎃","🕷️","😈", "💀", "🕸️", "🧙🏻‍♀️", "🙀", "👹", "😱", "☠️", "🍭","👻","🎃","🕷️","😈", "💀", "🕸️", "🧙🏻‍♀️", "🙀", "👹", "😱", "☠️", "🍭"],
        "animals":
            ["🐱", "🐶", "🐯", "🐭", "🐰", "🐷", "🦊", "🐼", "🐵", "🐨", "🐮", "🐱", "🐶", "🐯", "🐭", "🐰", "🐷", "🦊", "🐼", "🐵", "🐨", "🐮"],
        "fruits":
            ["🍎", "🍒", "🍋", "🍑", "🥭", "🍈", "🍏", "🍇", "🥝", "🍌", "🍍", "🍎", "🍒", "🍋", "🍑", "🥭", "🍈", "🍏", "🍇", "🥝", "🍌", "🍍"]]
    
    @State var cardCount: Int = 22
    @State var currentTheme: String = "halloween"
    
    var body: some View {
        NavigationView {
            VStack {
                cards
                    .animation(.default, value: viewModel.cards)
                Spacer()
                //                themeChangers
                HStack {
                    Button("Suffle") {
                        viewModel.shuffle()
                    }
                    Spacer()
                    Button("New Game") {
                        viewModel.newGame()
                    }
                }
            }
            .navigationTitle("Memorize!")
            .padding()
        }
        
    }
    
    

    @ViewBuilder
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) {
            card in CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.orange)
    }
    
}

//Views are immutable
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            //inside the View builder, always use let because the value cannot change
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1: 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1:0)
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
