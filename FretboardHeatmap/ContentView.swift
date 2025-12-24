//
//  ContentView.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2025-12-18.
//

import SwiftUI

struct ContentView: View {
    @State private var activeMenu: String? = nil // "Chords" or "Scales" tracker
    @State private var selectedRoot: String? = nil // Current Selected Chord or Scale
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Top Menu
            HStack(spacing: 40) {
                Button(action: { 
                    activeMenu = "Chords"
                    selectedRoot = nil}) {
                    Text("CHORDS")
                        .font(.system(.headline))
                        .foregroundColor(activeMenu == "Chords" ? .yellow : .white)
                }
                
                Button(action: { 
                    activeMenu = "Scales"
                    selectedRoot = nil }) {
                    Text("SCALES")
                        .font(.system(.headline))
                        .foregroundColor(activeMenu == "Scales" ? .yellow : .white)
                }
            }
            .padding(.bottom, 15)
            
            // Guitar Neck
            ZStack {
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
            
            Spacer()
            
            // Bottom Menu
            if activeMenu == "Chords" {
                HStack(spacing: 20) {
                    let labels = ["G", "D", "C", "E", "A", "Am"]
                    
                    ForEach(labels, id: \.self) { label in
                        Button(action: { selectedRoot = label }) {
                            Text(label)
                                .font(.system(.title3, design: .monospaced))
                                .padding()
                                .frame(width: 60, height: 50)
                                .background(Color.white.opacity(0.1))
                                .foregroundColor(selectedRoot == label ? .yellow : .white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.top, -30)
            } else if activeMenu == "Scales" {
                HStack(spacing: 20) {
                    let labels = ["G", "D", "C", "E", "A", "Am"]
                    
                    ForEach(labels, id: \.self) { label in
                        Button(action: { selectedRoot = label }) {
                            Text(label)
                                .font(.system(.title3, design: .monospaced))
                                .padding()
                                .frame(width: 60, height: 50)
                                .background(Color.white.opacity(0.1))
                                .foregroundColor(selectedRoot == label ? .yellow : .white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.top, -30)
            }
        }
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    ContentView()
}
