//
//  ContentView.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2025-12-18.
//
//  The Main Hub / UI

import SwiftUI

struct ContentView: View {
    @State private var noteLabels: Bool = false // Toggle note label display
    @State private var activeMenu: NavMode? = nil // "Chords" or "Scales" tracker
    @State private var selectedScaleType: String = "Maj Pentatonic" // Scale Dropdown
    @State private var selectedRoot: String? = nil // Current Selected Chord or Scale
    
    static let roots = ["G", "D", "C", "E", "A"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            topMenuArea
            
            ZStack {
               guitarNeckView 
               guitarStringsView
               heatmapView
            }
            
            Spacer() // Prevent default white background
            
            bottomMenuArea
        }
        .background(Color.black.ignoresSafeArea())
        
        .sensoryFeedback(.selection, trigger: activeMenu)
        .sensoryFeedback(.selection, trigger: selectedRoot)

    }
    
    // MARK: Top Menu
    private var topMenuArea: some View {
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
        }
    
    // MARK: Guitar Neck / Frets
    private var guitarNeckView: some View {
            ZStack {
                // Fretboard Wood
                RoundedRectangle(cornerRadius: 0)
                    .fill(LinearGradient(
                        colors: [
                            Color(red: 0.1, green: 0, blue: 0.02),
                            Color(red: 0.25, green: 0.15, blue: 0.1),
                            Color(red: 0.1, green: 0.05, blue: 0.02)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .frame(height: 280)
                    .padding(.top, -45)
                
                // Frets (1-12)
                HStack(spacing: 0) {
                    Rectangle().fill(Color(white: 0.9)).frame(width: 10) // Nut
                    
                    ForEach(0..<12, id: \.self) { index in
                        let fret = GuitarSpecs.frets[index]
                        Color.clear
                            .frame(width: fret)
                            .overlay {
                                if [2, 4, 6, 8].contains(index) {
                                    Circle().fill(Color(white: 0.7)).frame(width: 20)
                                }
                                if index == 11 {
                                    VStack(spacing: 80) {
                                        Circle().fill(Color(white: 0.7)).frame(width: 20)
                                        Circle().fill(Color(white: 0.7)).frame(width: 20)
                                    }
                                }
                            }
                        Rectangle().fill(Color.gray).frame(width: 3)
                    }
                    Spacer()
                }
                .frame(height: 280)
                .padding(.top, -45)
            }
        }
    
    // MARK: Guitar Strings
    private var guitarStringsView: some View {
        VStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { index in
                Spacer()
                Rectangle()
                    .fill(Color(white: 0.6))
                    .frame(height: GuitarSpecs.strings[index])
            }
            Spacer()
        }
        .frame(height: 350)
        .padding(.top, -45)
    }
    
    // MARK: Heatmap
    private var heatmapView: some View {
        HeatmapLogic(
            selectedRoot: selectedRoot,
            activeMenu: activeMenu,
            selectedScaleType: selectedScaleType,
            noteLabels: noteLabels,
            frets: GuitarSpecs.frets
        )
        .frame(height: 350)
        .padding(.top, -45)
    }
    
    // MARK: - Bottom Menu
        @ViewBuilder
        private var bottomMenuArea: some View {
            if activeMenu != nil {
                HStack(spacing: 20) {
                    ForEach(ContentView.roots, id: \.self) { root in
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.2)) {
                                selectedRoot = (selectedRoot == root) ? nil : root
                            }
                        }) {
                            Text(LabelMapping.getBottomMenuLabels(for: root, activeMenu: activeMenu, selectedScaleType: selectedScaleType)).font(.system(.headline))
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
}

#Preview {
    ContentView()
}
