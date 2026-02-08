//
//  TopMenuDropdown.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-17.
//
//  Renders a dropdown for chord and scale options

import SwiftUI

struct TopMenuDropdown: View {
    @Binding var selectedDropdownOption: String
    let activeMenu: NavMode?
    
    var body: some View {
        Menu { // Dropdown menu
            if let currentMenu = activeMenu {
                ForEach(FretPositions.dictionaries(for: currentMenu), id: \.self) { dropdownChoice in
                    Button(dropdownChoice) {
                        withAnimation { self.selectedDropdownOption = dropdownChoice }
                    }
                }
            }
        } label: { // Dropdown labels
            HStack(spacing: 5) {
                Text(selectedDropdownOption.uppercased())
                    .font(.system(size: 17, weight: .bold))
                Image(systemName: "chevron.down")
                    .font(.headline)
            }
            .frame(minWidth: 195, alignment: .trailing)
            .foregroundColor(.yellow)
        }
    }
}
