//
//  ContentView.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2025-12-18.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            // Background
            Color.black.ignoresSafeArea()
            
            // Fretboard Wood
            RoundedRectangle(cornerRadius: 0)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.1, green: 0, blue: 0.02), // Top
                            Color(red: 0.25, green: 0.15, blue: 0.1), // Middle
                            Color(red: 0.1, green: 0.05, blue: 0.02)  // Bottom
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 280) // Neck width
                .padding(.top, -45)
            
            
            // Frets (1-12)
            let frets: [CGFloat] = [90, 85, 80, 75, 71, 67, 63, 60, 56, 53, 50, 47]
            
            HStack(spacing: 0) {
                // Guitar Nut
                Rectangle()
                    .fill(Color(white: 0.9))
                    .frame(width: 10)
                
                // Frets
                ForEach(frets.indices, id: \.self) { index in
                    let fret = frets[index]
                    
                    // Fret Dots
                        ZStack {
                            Spacer().frame(width: fret)
                            
                            // Single Dots (Frets 3, 5, 7, 9)
                            if [2, 4, 6, 8].contains(index) {
                                Circle()
                                    .fill(Color(white: 0.7))
                                    .frame(width: 20)
                            }
                            
                            // Double Dots (Fret 12)
                            if index == 11 {
                                VStack(spacing: 80) { // between dots
                                    Circle().fill(Color(white: 0.7)).frame(width: 20)
                                    Circle().fill(Color(white:0.7)).frame(width: 20)
                                }
                            }
                        }
                        
                    // Fret Wire
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 3)
                    
                    }
                
                Spacer()
            }
            .frame(height: 280) // Fret Width
            .padding(.top, -45)
            
            
            // Strings
            let strings: [CGFloat] = [0.8, 1.2, 1.8, 2.5, 3.2, 4.0] // high E to low E
            
            VStack(spacing: 0) {
                ForEach(0..<6, id: \.self) { index in
                    Spacer()
                    
                    Rectangle()
                        .fill(Color(white: 0.6))
                        .frame(height: strings[index])
                }
                Spacer()
            }
            .frame(height: 350)
            .padding(.top, -45)
        }
    }
}

#Preview {
    ContentView()
}
