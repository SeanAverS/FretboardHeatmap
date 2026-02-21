//
//  HeatmapLogic.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-20.
//

import SwiftUI

/// Calculate and display fret positions on the fretboard
struct HeatmapLogic: View {
    let selectedRoot: String?
    let activeMenu: menuChoice?
    let selectedDropdownOption: String
    let noteLabels: Bool
    let frets: [CGFloat]
    
    // MARK: Display frets
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { string in
                Spacer() // Center Vertically
                
                // Display frets
                Color.clear
                    .frame(height: 1.0)
                    .overlay(alignment: .leading) {
                        heatmapFrets(for: string)
                    }
            }
            Spacer() // Center Horizontally
        }
    }
    
    // MARK: Prepare frets for the heatmap
    /// Prepare frets for the heatmap
    /// - Parameters:
    ///    - string: The current string
    @ViewBuilder
    private func heatmapFrets(for string: Int) -> some View {
        if let root = selectedRoot, let activeMenu = activeMenu {
            // selected root frets
            let positions = FretPositions.getFretMap(activeMenu: activeMenu, dropdownChoice: selectedDropdownOption, root: root)
            
            // center frets
            ForEach(positions[string] ?? [], id: \.self) { fret in
                
                if fret > 0 && fret <= frets.count {
                    centerNotes(root: root, string: string, fret: fret)
                }
            }
        }
    }

    // MARK: Calculate center of fret and label positions
    /// Calculate center of fret and label positions
    /// - Parameters:
    ///    - root: The current root
    ///    - string: The current string
    ///    - fret: The current fret
    @ViewBuilder
    private func centerNotes(root: String, string: Int, fret: Int) -> some View {
        // center of fret
        // total width from fret 1 to current fret
        let woodDistance = frets.prefix(fret).reduce(0.0, +)
        
        // account for fret 1 to current fret wire widths
        let wireOffset = CGFloat(fret) * 3.0
        
        // - half of current frets rightmost edge
        let thisFretWidth = frets[fret - 1]
        let centerOfWood = (woodDistance + wireOffset) - (thisFretWidth / 2.0)
        
        // center of labels
        NoteCircle(
            root: root,
            string: string,
            fret: fret,
            activeMenu: activeMenu,
            dropdown: selectedDropdownOption,
            showLabels: noteLabels)
        .offset(x: centerOfWood - 3.5)
        .transition(.opacity.combined(with: .scale))
    }
}

// MARK: Style frets
/// Determine the notes color and label
struct NoteCircle: View {
    let nonRootNoteLabel: String
    let rootNoteLabel: Bool
    let noteLabels: Bool
    
    // labels
    init(root: String, string: Int, fret: Int, activeMenu: menuChoice?, dropdown: String, showLabels: Bool) {
        self.rootNoteLabel = RootNotePositions.check(root: root, string: string, fret: fret)
        self.nonRootNoteLabel = FretLabels.getLabels(activeMenu: activeMenu, root: root, dropdownChoice: dropdown, string: string, fret: fret)
        self.noteLabels = showLabels
    }

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
