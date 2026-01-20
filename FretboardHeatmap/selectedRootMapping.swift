//
//  selectedRootMapping.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2025-12-26.
//
//  Returns fret positions of the selected chord or scale root
//  Parameters
    // root: the selected chord/scale
    // mode: current menu

import Foundation

enum NavMode: String {
    case chords
    case scales
}

struct SelectedRootMapping {
    
    static func getFretMap(for root: String, mode: NavMode?, type: String) -> [Int: [Int]] {
        if mode == .chords { // Cowboy Chords
            switch root { // [string: [fret]
            case "G":  return [0: [3], 4: [2], 5: [3]]
            case "D":  return [0: [2], 1: [3], 2: [2]]
            case "C":  return [1: [1], 3: [2], 4: [3]]
            case "E":  return [2: [1], 3: [2], 4: [2]]
            case "A":  return [1: [2], 2: [2], 3: [2]]
            default:   return [:]
            }
        }
        
        if mode == .scales {  // Major Pentatonic
            switch root { // [string: [frets...]
            case "G":
                return [
                    0: [0, 3, 5, 7, 10, 12],
                    1: [0, 3, 5, 8, 10, 12],
                    2: [0, 2, 4, 7, 9, 12],
                    3: [0, 2, 5, 7, 9, 12],
                    4: [0, 2, 5, 7, 10, 12],
                    5: [0, 3, 5, 7, 10, 12]  
                ]
                
            case "D":
                return [
                    0: [0, 2, 5, 7, 10, 12],
                    1: [0, 3, 5, 7, 10, 12],
                    2: [2, 4, 7, 9, 11],
                    3: [0, 2, 4, 7, 9, 12],
                    4: [0, 2, 5, 7, 9, 12],
                    5: [0, 2, 5, 7,10, 12]  
                ]
                
            case "C":
                return [
                    0: [0, 3, 5, 8, 10, 12],
                    1: [1, 3, 5, 8, 10],
                    2: [0, 2, 5, 7, 9, 12],
                    3: [0, 2,5, 7, 10, 12],
                    4: [3, 5, 7, 10, 12],
                    5: [0, 3, 5, 8, 10, 12]
                ]

            case "E":
                return [
                    0: [0, 2, 4, 7, 9, 12],
                    1: [2, 5, 7, 9, 12],
                    2: [1, 4, 6, 9, 11],
                    3: [2, 4, 6, 9, 11],
                    4: [2, 4, 7, 9, 11],
                    5: [2, 4, 7, 9, 12]
                ]
                
            case "A":
                return [
                    0: [2, 5, 7, 9, 12],
                    1: [2, 5, 7, 10, 12],
                    2: [2, 4, 6, 9, 11],
                    3: [2, 4, 7, 9, 11],
                    4: [2, 4, 7, 9, 12],
                    5: [2, 5, 7, 9, 12]
                ]
                
            default:
                return [:]
            }
        }
        return [:]
    }
}
