//
//  TopMenuKeyMatcher.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-02-11.
//

import Foundation

/// Display same key for new top menu choice
struct TopMenuKeyMatcher {
    
    /// Prepare key for new top menu choice
    /// - Keeps heatmap and bottom menu display consistent for user
    /// - Parameters:
    ///    - currentOption: The current chord or scale
    ///    - activeMenu: Top menu choice
    /// - Returns: Equivalent key for the new menu choice
    static func getMatch(for currentOption: String, activeMenu selected: menuChoice) -> String {
        if selected == .scales {
            return chordToScale[currentOption] ?? "Maj Pentatonic"
        } else {
            return scaleToChord[currentOption] ?? "Major"
        }
    }
    
    private static let scaleToChord: [String: String] = [
        "Ionian": "Major",
        "Maj Pentatonic": "Major",
        "Min Pentatonic": "Minor"
    ]
    
    private static let chordToScale: [String: String] = [
        "Major": "Maj Pentatonic",
        "Minor": "Min Pentatonic"
    ]
}
