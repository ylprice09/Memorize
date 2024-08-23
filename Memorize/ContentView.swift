//
//  ContentView.swift
//  Memorize
//
//  Created by Lin Price on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
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
                }
                Spacer()
                themeChangers
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
        LazyVGrid(columns:[GridItem(.adaptive(minimum: 50))]) {
            ForEach(0..<cardCount, id: \.self) {
                index in CardView(content: emojis[currentTheme]![index])
                    .aspectRatio(2/3, contentMode: .fit)
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
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            //inside the View builder, always use let because the value cannot change
            let base : RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1: 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
