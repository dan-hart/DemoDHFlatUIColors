//
//  ContentView.swift
//  DemoDHFlatUIColors
//
//  Created by Dan Hart on 11/11/24.
//

import SwiftUI
import DHFlatUIColors

struct ContentView: View {
    @ScaledMetric private var size: CGFloat = 30
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(DHFlatUIColors.Palette.allCases, id: \.self) { palette in
                    NavigationLink(destination: PaletteView(palette: palette)) {
                        HStack {
                            Text(palette.name)
                                .font(.headline)
                            Spacer()
                            HStack {
                                ForEach(palette.colors.prefix(3), id: \.name) { color in
                                    Rectangle()
                                        .frame(width: size, height: size)
                                        .foregroundStyle(color.color)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("DemoDHFlatUIColors")
        }
    }
}

#Preview {
    ContentView()
}
