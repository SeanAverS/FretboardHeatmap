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
    @State private var activeMenu: menuChoice? = nil // "Chords" or "Scales" tracker
    @State private var selectedDropdownOption: String = "Initial Display" // Dropdown
    @State private var selectedRoot: String? = nil // Current Selected Chord or Scale
    
    var body: some View {
        VStack(spacing: 0.0) {
            
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
                    topMenuButton("LABELS", isSelected: noteLabels) {
                        noteLabels.toggle()
                    }
                    
                    // Chords
                    topMenuButton("CHORDS", isSelected: activeMenu == .chords) {
                        handleActiveMenuSwitch(to: .chords)
                    }

                    // Scales
                    topMenuButton("SCALES", isSelected: activeMenu == .scales) {
                        handleActiveMenuSwitch(to: .scales)
                    }
                }
                
                // Dropdown
                HStack {
                    Spacer() // position far right
                    
                    if let activeMenu = activeMenu {
                        TopMenuDropdown(selectedDropdownOption: $selectedDropdownOption, activeMenu: activeMenu)
                    }
                }
            }
            .padding(.bottom, 15)
            .frame(maxWidth: .infinity)
        }
    // topMenuArea Helper for buttons
    private func topMenuButton(_ title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: {
            withAnimation(.easeIn(duration: 0.3)) {
                action()
            }
        }) {
            Text(title)
                .font(.system(.headline))
                .foregroundColor(isSelected ? .yellow : .white)
        }
    }
    // topMenuArea consistent activeMenu key switching
    private func handleActiveMenuSwitch(to selected: menuChoice) {
        guard activeMenu != selected else { return } // prevent multiple taps showing default option

        let matchedOption = TopMenuKeyMatcher.getMatch(for: selectedDropdownOption, activeMenu: selected)
        
        activeMenu = selected
        selectedDropdownOption = matchedOption
    }
    
    // MARK: Guitar Neck / Frets
    private var guitarNeckView: some View {
            ZStack {
                // Fretboard Wood
                RoundedRectangle(cornerRadius: 0.0)
                    .fill(LinearGradient(
                        colors: [
                            Color(red: 0.1, green: 0, blue: 0.02),
                            Color(red: 0.25, green: 0.15, blue: 0.1),
                            Color(red: 0.1, green: 0.05, blue: 0.02)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .frame(height: 280.0)
                    .padding(.top, -45)
                
                // Frets (1-12)
                HStack(spacing: 0) {
                    Rectangle().fill(Color(white: 0.9)).frame(width: 10) // Nut
                    
                    ForEach(0..<12, id: \.self) { index in
                        let fret = GuitarSpecs.frets[index]
                        Color.clear
                            .frame(width: fret)
                            .overlay {
                                fretInlays(for: index)
                            }
                        Rectangle().fill(Color.gray).frame(width: 3)
                    }
                    Spacer()
                }
                .frame(height: 280.0)
                .padding(.top, -45)
            }
        }
    // guitarNeckView Helper for fret inlays
        @ViewBuilder
    private func fretInlays(for index: Int) -> some View {
        if [2, 4, 6, 8].contains(index) { // single dot
            Circle()
                .fill(Color(white: 0.7))
                .frame(width: 20.0, height: 20.0)
        } else if index == 11 { // double dot
            VStack(spacing: 80.0) {
                Circle().fill(Color(white: 0.7)).frame(width: 20.0, height: 20.0)
                Circle().fill(Color(white: 0.7)).frame(width: 20.0, height: 20.0)
            }
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
                    .frame(maxWidth: .infinity)
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
            selectedDropdownOption: selectedDropdownOption,
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
                    ForEach(GuitarSpecs.roots, id: \.self) { root in
                        
                        let bottomMenulabels = BottomMenuLabels.getLabels(
                            for: root,
                            activeMenu: activeMenu,
                            dropdownChoice: selectedDropdownOption
                        )
                        
                        let isSelected: Bool = (selectedRoot == root)
                        
                        // Highlight selected root
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.3)) {
                                selectedRoot = root
                            }
                        })
                        {
                            Text(bottomMenulabels)
                                .font(.system(.headline))
                                .frame(width: 70.0, height: 50.0)
                                .background(Color.white.opacity(0.1))
                                .foregroundColor(isSelected ? .yellow : .white)
                                .cornerRadius(8.0)
                        }
                    }
                }
                .padding(.top, -30.0)
            }
        }
        
}

#Preview {
    ContentView()
}
