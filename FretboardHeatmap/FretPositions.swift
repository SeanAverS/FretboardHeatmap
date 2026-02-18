//
//  FretPositions.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2025-12-26.
//

import Foundation

/// Available top menu choices
enum menuChoice: String {
    case chords
    case scales
}

/// Manages fret note and finger positions
struct FretPositions {
    
    /// Prepare dictionaries for top menu dropdown
    /// - Parameters:
    ///   - activeMenu: Top menu choice
    /// - Returns: Options for right top menu dropdown
    static func dropdownChoices(for activeMenu: menuChoice) -> [String] {
        switch activeMenu {
        case .chords:
            return Array(chords.keys).sorted()
        case .scales:
            return Array(scales.keys).sorted()
        }
    }
    
    /// Prepare fret notes for heatmap
    /// - Parameters:
    ///    - activeMenu: Top menu choice
    ///    - dropdownChoice: Top menu dropdown choice
    ///    - root: Root note choice
    /// - Returns: Dictionary for "chords" or "scales"
    static func getFretMap(activeMenu: menuChoice?, dropdownChoice: String, root: String, ) -> [Int: [Int]] {
        guard let activeMenu = activeMenu else { return [:] }
        
        switch activeMenu {
        case .chords:
            return chords[dropdownChoice]?[root] ?? [:]
        case .scales:
            return scales[dropdownChoice]?[root] ?? [:]
        }
        
    }
    
    /// Get finger numbers for chords
    /// - Parameters:
    ///    - dropdownChoice: Top menu dropdown choice
    ///    - root: Root note choice
    ///    - string: current string
    ///    - fret: current fret
    /// - Returns: finger number positions for chords
    static func getFingerNumber(dropdownChoice: String, root: String, string: Int, fret: Int) -> String {
        let key = "\(string),\(fret)"
        
        return fingerNumbers[dropdownChoice]?[root]?[key] ?? ""
        
    }
    
    // MARK: Scales dictionary
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
        ],
        "Ionian": [
            "G": [0: [2, 3, 5, 7, 8, 10, 12], 1: [1, 3, 5, 7, 8, 10, 12], 2: [2, 4, 5, 7, 9, 11, 12], 3: [2, 4, 5, 7, 9, 10, 12], 4: [2, 3, 5, 7, 9, 10, 12], 5: [ 2, 3, 5, 7, 8, 10, 12]],
            "D": [0: [2, 3, 5, 7, 9, 10, 12], 1: [2, 3, 5, 7, 8, 10, 12], 2: [2, 4, 6, 7, 9, 11, 12], 3: [2, 4, 5, 7, 9, 11, 12], 4: [2, 4, 5, 7, 9, 10, 12], 5: [2, 3, 5, 7, 9, 10, 12]],
            "C": [0: [1, 3, 5, 7, 8, 10, 12], 1:[1, 3, 5, 6, 8, 10, 12], 2: [2, 4, 5, 7, 3, 4, 12], 3: [2,3, 5, 7, 9, 10, 12], 4: [2, 3, 5, 7, 8, 10, 12], 5: [1, 3, 5, 7, 8, 10, 12]],
            "E": [0: [2, 4, 5, 7, 9, 11, 12], 1: [2, 4, 5, 7, 9, 10, 12], 2: [1, 2, 4, 6, 8, 9, 11], 3: [1, 2, 4, 6, 7, 9, 11], 4: [2, 4, 6, 7, 9, 11, 12], 5: [2, 4, 5, 7, 9, 11, 12]],
            "A": [0: [2, 4, 5, 7, 9, 10, 12], 1: [2, 3, 5, 7, 9, 10, 12], 2: [1, 2, 4, 6, 7, 9, 11], 3: [2, 4, 6, 7, 9, 11, 12], 4: [2, 4, 5, 7, 9, 11, 12], 5: [2, 4, 5, 7, 9, 10, 12]]
        ]
    ]
    
    // MARK: - Chords dictionary 
    private static let chords: [String: [String: [Int: [Int]]]] = [
        "Major": [
            "G": [0: [3], 4: [2], 5: [3]],
            "D": [0: [2], 1: [3], 2: [2]],
            "C": [1: [1], 3: [2], 4: [3]],
            "E": [2: [1], 3: [2], 4: [2]],
            "A": [1: [2], 2: [2], 3: [2]]
        ],
        "Minor": [
            "A": [1: [1], 2: [2], 3: [2]],
            "E": [3: [2], 4: [2]],
            "D": [0: [1], 1: [3], 2: [2]],
            "G": [0: [3], 1: [3], 2: [3], 3: [5], 4: [5], 5: [3]],
            "C": [0: [3], 1: [4], 2: [5], 3: [5]]
        ]
    ]
    
    // MARK: Finger numbers dictionary
    private static let fingerNumbers: [String: [String: [String: String]]] = [
        "Major": [
                "G": ["5,3": "2", "4,2": "1", "0,3": "3"],
                "D": ["2,2": "1", "1,3": "3", "0,2": "2"],
                "C": ["4,3": "3", "3,2": "2", "1,1": "1"],
                "E": ["2,1": "1", "3,2": "3", "4,2": "2"],
                "A": ["3,2": "1", "2,2": "2", "1,2": "3"]
            ],
        "Minor": [
            "A": ["1,1": "1", "2,2": "3", "3,2": "2"],
            "E": ["3,2": "2", "4,2": "1"],
            "D": ["0,1": "1", "1,3": "3", "2,2": "2"],
            "C": ["3,5": "3", "2,5": "4", "1,4": "2", "0,3": "1"],
            "G": ["5,3": "1", "4,5": "3", "3,5": "4", "2,3": "1", "1,3": "1", "0,3": "1"]
        ]
    ]
}
