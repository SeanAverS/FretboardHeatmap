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
                
                // Fret Spacing
                ForEach(frets.indices, id: \.self) { index in
                    let fret = frets[index]
                    
                    // Fret Wire
                    HStack(spacing: 0) {
                        Spacer().frame(width: fret)
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 3)
                    }
                }
                
                Spacer()
            }
            .frame(height: 280) // Fret Width
            .padding(.top, -45)
        }
    }
}

#Preview {
    ContentView()
}
