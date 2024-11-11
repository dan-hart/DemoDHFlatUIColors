//
//  PaletteView.swift
//  DemoDHFlatUIColors
//
//  Created by Dan Hart on 11/11/24.
//

import SwiftUI
import DHFlatUIColors

struct PaletteView: View {
    let palette: DHFlatUIColors.Palette
    @ScaledMetric private var size: CGFloat = 100
    
    var body: some View {
        List {
            ForEach(palette.colors, id: \.name) { color in
                HStack {
                    Rectangle()
                        .frame(width: size, height: size)
                        .foregroundStyle(color.color)
                    VStack(alignment: .leading) {
                        Text(color.name)
                            .font(.headline)
                        Text(color.hex)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button {
                        #if os(iOS)
                        UIPasteboard.general.string = color.hex
                        #elseif os(macOS)
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(color.hex, forType: .string)
                        #endif
                    } label: {
                        Label {
                            Text("Copy Hex")
                        } icon: {
                            Image(systemName: "doc.on.doc")
                        }
                        .foregroundStyle(.primary)
                        #if os(iOS)
                        .labelStyle(.iconOnly)
                        #endif
                        .imageScale(.large)
                    }
                }
            }
        }
    }
}

#Preview {
    PaletteView(palette: .flatUiV1)
}

