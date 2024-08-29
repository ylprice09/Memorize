//
//  ContentView.swift
//  Memorize
//
//  Created by Lin Price on 8/12/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
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
                ScrollView {
                    cards
                        .animation(.default, value: viewModel.cards)
                }
                Spacer()
//                themeChangers
                Button("Suffle") {
                    viewModel.shuffle()
                }
            }
            .navigationTitle("Memorize!")
            .padding()
        }
        
    }
    

    var themeChangers: some View {
        HStack {
            halloweenTheme
            Spacer()
            animalTheme
            Spacer()
            fruitTheme
        }
    }
    

    func themeChanger(image: String, theme: String) -> some View {
        Button(action: {
        currentTheme = theme
        emojis[theme]?.shuffle()
        }) {
            VStack {
                Image(systemName: image)
                    .font(.largeTitle)  // Make the image larger
                Text(theme)
                    .font(.caption)     // Make the text smaller
            }
        }
    }
    

    
    var cards: some View {
        LazyVGrid(columns:[GridItem(.adaptive(minimum: 70), spacing:0)], spacing: 0) {
            ForEach(viewModel.cards) {
                card in CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
    
    var halloweenTheme: some View {
        themeChanger(image: "moon", theme: "halloween")
    }
    
    var fruitTheme: some View {
        themeChanger(image: "applelogo", theme: "fruits")
    }
    
    var animalTheme: some View {
        themeChanger(image: "cat.circle.fill" ,theme: "animals")
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
