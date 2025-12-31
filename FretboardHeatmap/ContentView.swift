//
//  ContentView.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2025-12-18.
//
//  The Main Hub / UI

import SwiftUI

struct ContentView: View {
    @State private var activeMenu: String? = nil // "Chords" or "Scales" tracker
    @State private var selectedRoot: String? = nil // Current Selected Chord or Scale
    
    let roots = ["G", "D", "C", "E", "A", "Am"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Top Menu
            HStack(spacing: 40) {
                Button(action: {
                    activeMenu = "Chords"
                    selectedRoot = nil })
                {
                    Text("CHORDS")
                        .font(.system(.headline))
                        .foregroundColor(activeMenu == "Chords" ? .yellow : .white)
                }
                
                Button(action: { 
                    activeMenu = "Scales"
                    selectedRoot = nil })
                {
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
                    .fill(LinearGradient(
                            colors: [
                                Color(red: 0.1, green: 0, blue: 0.02), // Top
                                Color(red: 0.25, green: 0.15, blue: 0.1), // Middle
                                Color(red: 0.1, green: 0.05, blue: 0.02)  // Bottom
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
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
                    Spacer() // Center Guitar Neck
                }
                .frame(height: 280) // Fret Width
                .padding(.top, -45)
                
                
                // Strings / Heatmap Logic
                let strings: [CGFloat] = [0.8, 1.2, 1.8, 2.5, 3.2, 4.0] // high E to low E
                
                VStack(spacing: 0) {
                    ForEach(0..<6, id: \.self) { index in
                        Spacer() // Center Vertical Strings
                        
                        ZStack(alignment: .leading) {
                            // Strings
                            Rectangle()
                                .fill(Color(white: 0.6))
                                .frame(height: strings[index])
                            
                            // HeatMap
                                .overlay(alignment: .leading) { // dont alter string size
                                    if let root = selectedRoot {
                                        // get fret positions
                                        let currentMap = SelectedRootMapping.getFretMap(for: root, mode: activeMenu)
                                        
                                        // calculate fret positions
                                        if let targetFret = currentMap[index] {
                                            let centerOfFret = frets.prefix(targetFret).reduce(0, +) - (frets[targetFret-1] / 2)
                                            //  targetFrets rightmost edge -  targetFrets width in half (centers the edge)
                                            
                                            // display fret positions
                                            Circle()
                                                .fill(Color.yellow)
                                                .frame(width: 24, height: 24)
                                                .shadow(color: .yellow.opacity(0.7), radius: 6)
                                                .offset(x: centerOfFret + 10 - 12)
                                            // + nutWidth - Circles rightmost edge (centers the dot)
                                                .transition(.opacity.combined(with: .scale))
                                        }
                                    }
                                }
                        }
                    }
                    Spacer() // Center Horizontal Strings
                }
                .frame(height: 350)
                .padding(.top, -45)
            }
            
            Spacer() // Prevent default white background
            
            // Bottom Menu
            if activeMenu != nil { // "Chord" or "Scales" tracker
                HStack(spacing: 20) {
                    ForEach(roots, id: \.self) { root in
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.2)) {
                                selectedRoot = root
                            }
                        })
                        {
                            Text(root)
                                .font(.system(.headline))
                                .frame(width: 70, height: 50)
                                .background(Color.white.opacity(0.1))
                                .foregroundColor(selectedRoot == root ? .yellow : .white)
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
