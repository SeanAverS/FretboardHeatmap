//
//  HeatmapLogic.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-20.
//
//  Calculate and Display fret positions for the selected root

import SwiftUI

struct HeatmapLogic: View {
    let selectedRoot: String? // selected chord or scale
    let activeMenu: menuChoice? // "Chords" or "Scales" tracker
    let selectedDropdownOption: String // Dropdown
    let noteLabels: Bool
    let frets: [CGFloat]
    
    // MARK: style fret positions
    struct NoteCircle: View {
        let nonRootNoteLabel: String
        let rootNoteLabel: Bool
        let noteLabels: Bool

        var body: some View {
            Circle()
                // size
                .fill(rootNoteLabel ? Color.red : Color.blue)
                .frame(width: 24.0, height: 24.0)
            
                // label
                .overlay {
                    if noteLabels {
                        Text(nonRootNoteLabel)
                            .font(.system(size: 15.0, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
        }
    }
    
    // MARK: Heatmap frets placement
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { stringIndex in
                Spacer() // Center Vertically
                
                // Heatmap
                Color.clear
                    .frame(height: 1.0)
                    .overlay(alignment: .leading) {
                        fretPositions(for: stringIndex)
                    }
            }
            Spacer() // Center Horizontally
        }
    }
    
    // MARK: get fret positions for Heatmap placement
    @ViewBuilder
    private func fretPositions(for stringIndex: Int) -> some View {
        // get fret positions for selected root
        if let root = selectedRoot, let activeMenu = activeMenu {
            let currentFretPositions = FretPositions.getFretMap(for: root, activeMenu: activeMenu, dropdownChoice: selectedDropdownOption)
            
            // display fret positions
            if let displayFrets = currentFretPositions[stringIndex] {
                ForEach(displayFrets, id: \.self) { targetFret in
                    if targetFret > 0 && targetFret <= frets.count {
                        noteMarker(root: root, string: stringIndex, fret: targetFret)
                            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: targetFret)
                    }
                }
            }
        }
    }

    // MARK: Calculate center of fret/label positions
    @ViewBuilder
    private func noteMarker(root: String, string: Int, fret: Int) -> some View {
        // center of fret
        let woodDistance = frets.prefix(fret).reduce(0.0, +)
        let wireOffset = CGFloat(fret) * 3.0
        let thisFretWidth = frets[fret - 1]
        let centerOfWood = (woodDistance + wireOffset) - (thisFretWidth / 2.0)
        
        // labels
        let rootNoteLabel = HighlightRootNote.check(root: root, string: string, fret: fret)
        let nonRootNoteLabel = FretLabels.getLabels(activeMenu: activeMenu, root: root, dropdownChoice: selectedDropdownOption, string: string, fret: fret)
        // center the labels
        NoteCircle(nonRootNoteLabel: nonRootNoteLabel, rootNoteLabel: rootNoteLabel, noteLabels: noteLabels)
            .offset(x: centerOfWood + 10.0 - 12.0 - 1.5) // account for rightmost fret edge 
            .transition(.opacity.combined(with: .scale))
    }
}

// Math Explanation
// woodDistance = frets.prefix(targetFret).reduce(0, +)
// total width from fret 1 to current fret

// wireOffset = CGFloat(targetFret) * 3
// account for fret 1 to current fret wire widths


// thisFretWidth = frets[targetFret - 1]
// centerOfWood = (woodDistance + wireOffset) - (thisFretWidth / 2)
// - half of current frets rightmost edge
