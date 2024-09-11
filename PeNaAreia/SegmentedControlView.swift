//
//  ProductDetailsView.swift
//  PeNaAreia
//
//  Created by Marina Meirelles Paixão on 28/08/24.
//

import SwiftUI

struct SegmentedControlView: View {
    @State private var selectedSegment = 0
    let segments = [
        (iconName: "fish.ic", label: "Comidas"),
        (iconName: "coco.ic", label: "Bebidas")
    ]

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<segments.count, id: \.self) { index in
                    Button(action: {
                        withAnimation {
                            selectedSegment = index
                        }
                    }) {
                        VStack {
                            HStack {
                                Image(segments[index].iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20) // Ajuste o tamanho conforme necessário
                                    .foregroundColor(selectedSegment == index ? .darkblue : .darkblue)
                                
                                Text(segments[index].label)
                                    .foregroundColor(selectedSegment == index ? .darkblue : .darkblue)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(selectedSegment == index ? .darkblue : .lightblue)
                        }
                    }
                }
            }
            .frame(height: 44)
            .background(Color.white)
        }
        .padding(.horizontal, 22.0)
    }
}

#Preview {
    SegmentedControlView()
}
