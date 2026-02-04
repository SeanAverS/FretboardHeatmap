//
//  selectedRootMapping.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2025-12-26.
//
//  Returns fret/finger positions of the selected root
//  Parameters
    // root: the selected chord/scale
    // mode: current menu

import Foundation

enum NavMode: String {
    case chords
    case scales
}

struct FretPositions {
    
    // MARK: Scales
    private static let scales: [String: [String: [Int: [Int]]]] = [
        "Min Pentatonic": [
            "G": [0: [1, 3, 6, 8, 10, 13], 1: [1, 3, 6, 8, 11, 13], 2: [3, 5, 7, 10, 12], 3: [3, 5, 8, 10, 12], 4: [1, 3, 5, 8, 10, 13], 5: [1, 3, 6, 8, 10, 13]],
            "D": [0: [1, 3, 5, 8, 10], 1: [1, 3, 6, 8, 10], 2: [2, 5, 7, 10, 12], 3: [0, 3, 5, 7, 10, 12], 4: [0, 3, 5, 8, 10, 12], 5: [1, 3, 5, 8, 10]],
            "C": [0: [1, 3, 6, 8, 11, 13], 1: [1, 4, 6, 8, 11, 13], 2: [0, 3, 5, 8, 10, 12], 3: [1, 3, 5, 8, 10, 13], 4: [1, 3, 6, 8, 10, 13], 5: [1, 3, 6, 8, 11, 13]],
            "E": [0: [0, 3, 5, 7, 10, 12], 1: [0, 3, 5, 8, 10, 12], 2: [0, 2, 4, 7, 9, 12], 3: [0, 2, 5, 7, 9, 12], 4: [0, 2, 5, 7, 10, 12], 5: [0, 3, 5, 7, 10, 12]],
            "A": [0: [0, 3, 5, 8, 10, 12], 1: [1, 3, 5, 8, 10, 13], 2: [2, 5, 7, 9, 12], 3: [2, 5, 7, 10, 12], 4: [0, 3, 5, 7, 10, 12], 5: [0, 3, 5, 8, 10, 12]]
        ],
        "Maj Pentatonic": [
            "G": [0: [0, 3, 5, 7, 10, 12], 1: [0, 3, 5, 8, 10, 12], 2: [0, 2, 4, 7, 9, 12], 3: [0, 2, 5, 7, 9, 12], 4: [0, 2, 5, 7, 10, 12], 5: [0, 3, 5, 7, 10, 12]],
            "D": [0: [0, 2, 5, 7, 10, 12], 1: [0, 3, 5, 7, 10, 12], 2: [2, 4, 7, 9, 11], 3: [0, 2, 4, 7, 9, 12], 4: [0, 2, 5, 7, 9, 12], 5: [0, 2, 5, 7, 10, 12]],
            "C": [0: [0, 3, 5, 8, 10, 12], 1: [1, 3, 5, 8, 10], 2: [0, 2, 5, 7, 9, 12], 3: [0, 2, 5, 7, 10, 12], 4: [3, 5, 7, 10, 12], 5: [0, 3, 5, 8, 10, 12]],
            "E": [0: [0, 2, 4, 7, 9, 12], 1: [2, 5, 7, 9, 12], 2: [1, 4, 6, 9, 11], 3: [2, 4, 6, 9, 11], 4: [2, 4, 7, 9, 11], 5: [2, 4, 7, 9, 12]],
            "A": [0: [2, 5, 7, 9, 12], 1: [2, 5, 7, 10, 12], 2: [2, 4, 6, 9, 11], 3: [2, 4, 7, 9, 11], 4: [2, 4, 7, 9, 12], 5: [2, 5, 7, 9, 12]]
        ]
    ]
    
    // MARK: Chords
    private static let chords: [String: [Int: [Int]]] = [
        "G": [0: [3], 4: [2], 5: [3]],
        "D": [0: [2], 1: [3], 2: [2]],
        "C": [1: [1], 3: [2], 4: [3]],
        "E": [2: [1], 3: [2], 4: [2]],
        "A": [1: [2], 2: [2], 3: [2]]
    ]
    
    // MARK: allows ScaleDropDown updates
    static var availableScales: [String] {
            return Array(scales.keys).sorted()
        }
    
    
    // MARK: fret notes
    static func getFretMap(for root: String, mode: NavMode?, type: String) -> [Int: [Int]] {
        guard let mode = mode else { return [:] }
        
        switch mode {
        case .chords:
            return chords[root] ?? [:]
        case .scales:
            return scales[type]?[root] ?? [:]
        }
        
    }
    
    // MARK: finger numbers for chords
    static func getFingerNumber(root: String, string: Int, fret: Int) -> String {
        switch root {
        case "G":
            if string == 5 && fret == 3 { return "2" }
            if string == 4 && fret == 2 { return "1" }
            if string == 0 && fret == 3 { return "3" }
        case "D":
            if string == 2 && fret == 2 { return "1" }
            if string == 1 && fret == 3 { return "3" }
            if string == 0 && fret == 2 { return "2" }
        case "C":
            if string == 4 && fret == 3 { return "3" }
            if string == 3 && fret == 2 { return "2" }
            if string == 1 && fret == 1 { return "1" }
        case "E":
            if string == 2 && fret == 1 { return "1" }
            if string == 3 && fret == 2 { return "3" }
            if string == 4 && fret == 2 { return "2" }
        case "A":
            if string == 3 && fret == 2 { return "1" }
            if string == 2 && fret == 2 { return "2" }
            if string == 1 && fret == 2 { return "3" }
        default: return ""
        }
        return ""
    }
}
