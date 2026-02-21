//
//  TopMenuDropdown.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-17.
//

import SwiftUI

/// Prepare dropdown for top menu area
/// - Parameters:
///    - selectedDropdownOption: The current dropdown choice
///    - activeMenu: Top menu choice
/// - Returns: Dropdown for right top menu choice
struct TopMenuDropdown: View {
    @Binding var selectedDropdownOption: String
    let activeMenu: menuChoice?
    
    var body: some View {
        Menu { // Dropdown
            if let activeMenu = activeMenu {
                ForEach(FretPositions.dropdownChoices(for: activeMenu), id: \.self) { dropdownChoice in
                    Button(dropdownChoice) {
                        withAnimation(.easeIn(duration: 0.3)) { self.selectedDropdownOption = dropdownChoice }
                    }
                }
            }
        } label: { // Styling
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
