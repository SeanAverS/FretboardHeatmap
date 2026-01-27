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
    let activeMenu: NavMode? // "Chords" or "Scales" tracker
    let selectedScaleType: String // Scale Dropdown menu
    let noteLabels: Bool
    let frets: [CGFloat]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { stringIndex in
                Spacer() // Center Vertically
                
                // Heatmap
                Color.clear
                    .frame(height: 1)
                    .overlay(alignment: .leading) {
                        fretPositions(for: stringIndex)
                    }
            }
            Spacer() // Center Horizontally
        }
    }
    
    // Process frets
    @ViewBuilder
    private func fretPositions(for stringIndex: Int) -> some View {
        // get fret positions for selected root
        if let root = selectedRoot, let mode = activeMenu {
            let currentMap = FretPositions.getFretMap(for: root, mode: mode, type: selectedScaleType)
            
            // display fret positions
            if let fretList = currentMap[stringIndex] {
                ForEach(fretList, id: \.self) { targetFret in
                    if targetFret > 0 && targetFret <= frets.count {
                        noteMarker(root: root, string: stringIndex, fret: targetFret)
                            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: targetFret)
                    }
                }
            }
        }
    }

    // Calculate center of fret/label positions
    @ViewBuilder
    private func noteMarker(root: String, string: Int, fret: Int) -> some View {
        // center of fret
        let woodDistance = frets.prefix(fret).reduce(0, +)
        let wireOffset = CGFloat(fret) * 3
        let thisFretWidth = frets[fret - 1]
        let centerOfWood = (woodDistance + wireOffset) - (thisFretWidth / 2)
        
        // root note label
        let isRootNote = HighlightRootNote.check(root: root, string: string, fret: fret)
        
        // non-root note label
        let labelText = LabelMapping.getFretboardLabels(
            activeMenu: activeMenu,
            root: root,
            string: string,
            fret: fret
        )
        Circle()
            .fill(isRootNote ? Color.red : Color.blue)
            .frame(width: 24, height: 24)
            .shadow(color: (isRootNote ? Color.red : Color.blue).opacity(0.7), radius: 6)
            .overlay {
                if noteLabels {
                    Text(labelText)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .offset(x: centerOfWood + 10 - 12 - 1.5)
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
