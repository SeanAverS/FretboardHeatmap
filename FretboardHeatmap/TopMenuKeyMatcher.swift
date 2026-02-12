//
//  TopMenuKeyMatcher.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-02-11.
//
//  Keeps the same Key displayed when switching between CHORDS or SCALES

import Foundation

struct TopMenuKeyMatcher {
    
    private static let scaleToChord: [String: String] = [
        "Ionian": "Major",
        "Maj Pentatonic": "Major",
        "Min Pentatonic": "Minor"
    ]
    
    private static let chordToScale: [String: String] = [
        "Major": "Maj Pentatonic",
        "Minor": "Min Pentatonic"
    ]
    
    static func getMatch(for currentOption: String, currentMenu mode: NavMode) -> String {
        if mode == .scales { // when in CHORDS and user taps SCALES
            return chordToScale[currentOption] ?? "Maj Pentatonic"
        } else { // when in SCALES and user taps CHORDS
            return scaleToChord[currentOption] ?? "Major"
        }
    }
}
