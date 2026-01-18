//
//  ContentView.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2025-12-18.
//
//  The Main Hub / UI

import SwiftUI

struct ContentView: View {
    @State private var activeMenu: NavMode? = nil // "Chords" or "Scales" tracker
    @State private var selectedRoot: String? = nil // Current Selected Chord or Scale
    @State private var noteLabels: Bool = false // Toggle note label display
    @State private var selectedScaleType: String = "Maj Pentatonic" // Scale Dropdown
    
    let roots = ["G", "D", "C", "E", "A"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Top Menu
            ZStack {
                HStack(spacing: 40) {
                    // Labels
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.2)) {
                            noteLabels.toggle()
                        }
                    })
                    {
                        Text("LABELS")
                            .font(.system(.headline))
                            .foregroundColor(noteLabels ? .yellow : .white)
                    }
                    
                    // Chords
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.2)) {
                            activeMenu = .chords
                        }
                    })
                    {
                        Text("CHORDS")
                            .font(.system(.headline))
                            .foregroundColor(activeMenu == .chords ? .yellow : .white)
                    }
                    
                    // Scales
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.2)) {
                            activeMenu = .scales
                        }
                    })
                    {
                        Text("SCALES")
                            .font(.system(.headline))
                            .foregroundColor(activeMenu == .scales ? .yellow : .white)
                    }
                }
                
                // Scale Dropdown
                HStack {
                    Spacer() // position far right
                    
                    if activeMenu == .scales {
                        ScaleDropDown(selectedScaleType: $selectedScaleType)
                    }
                }
            }
            .padding(.bottom, 15)
            .frame(maxWidth: .infinity)
            
            // MARK: Guitar Neck / Frets
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
                        Color.clear
                            .frame(width: fret)
                            .overlay {
                                // Single Dots (Frets 3, 5, 7, 9)
                                if [2, 4, 6, 8].contains(index) {
                                    Circle()
                                        .fill(Color(white: 0.7))
                                        .frame(width: 20)
                                }
                                
                                // Double Dots (Fret 12)
                                if index == 11 {
                                    VStack(spacing: 80) {
                                        Circle().fill(Color(white: 0.7)).frame(width: 20)
                                        Circle().fill(Color(white: 0.7)).frame(width: 20)
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
                
                
                // MARK: - Guitar Strings / Heatmap
                let strings: [CGFloat] = [0.8, 1.2, 1.8, 2.5, 3.2, 4.0] // high E to low E
                
                VStack(spacing: 0) {
                    ForEach(0..<6, id: \.self) { index in
                        Spacer() // Center Vertical Strings
                        
                        // Strings
                        Rectangle()
                            .fill(Color(white: 0.6))
                            .frame(height: strings[index])
                        
                        // MARK: Heatmap Logic
                            .overlay(alignment: .leading) { // dont alter string size
                                if let root = selectedRoot {
                                    // get fret positions for all strings
                                    let currentMap = SelectedRootMapping.getFretMap(for: root, mode: activeMenu)
                                    
                                    // get fret positions for current string
                                    if let fretList = currentMap[index] {
                                        
                                        // process each fret on current string
                                        ForEach(fretList, id: \.self) { targetFret in
                                            if targetFret > 0 && targetFret <= frets.count {
                                                
                                                let woodDistance = frets.prefix(targetFret).reduce(0, +)
                                                // total width from fret 1 to current fret
                                                
                                                let wireOffset = CGFloat(targetFret) * 3
                                                // account for fret 1 to current fret wire widths
                                                
                                                // calculate center of current fret
                                                let thisFretWidth = frets[targetFret - 1]
                                                let centerOfWood = (woodDistance + wireOffset) - (thisFretWidth / 2)
                                                // - half of current frets rightmost edge
                                                
                                                // display fret positions / labels
                                                let isRootNote = HighlightRootNote.check(root: root, string: index, fret: targetFret)
                                                
                                                Circle()
                                                    .fill(isRootNote ? Color.red : Color.blue)
                                                    .frame(width: 24, height: 24)
                                                    .shadow(color: (isRootNote ? Color.red : Color.blue).opacity(0.7), radius: 6)
                                                    .overlay {
                                                            if noteLabels {
                                                                Text(NoteLabelMapping.getNoteName(string: index, fret: targetFret))
                                                                    .font(.system(size: 15, weight: .bold))
                                                                    .foregroundColor(.white)
                                                            }
                                                        }
                                                    .offset(x: centerOfWood + 10 - 12 - 1.5)
                                                // + nutWidth - Circle rightmost edge - Wires rightmost edge
                                                    .transition(.opacity.combined(with: .scale))
                                            }
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
            
            // MARK: - Bottom Menu
            if activeMenu != nil { // "Chord" or "Scales" tracker
                HStack(spacing: 20) {
                    ForEach(roots, id: \.self) { root in
                        Button(action: { // deselect root
                            withAnimation(.easeIn(duration: 0.2)) {
                                selectedRoot = (selectedRoot == root) ? nil : root
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
        
        .sensoryFeedback(.selection, trigger: activeMenu)
        .sensoryFeedback(.selection, trigger: selectedRoot)
    }
}

#Preview {
    ContentView()
}
