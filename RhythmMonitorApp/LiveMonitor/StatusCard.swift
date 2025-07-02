//
//  StatusCard.swift
//  RhythmMonitorApp
//
//  Created by Furkan Cinko on 31.05.2025.
//

/*import SwiftUI

struct StatusCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title3)
                Spacer()
            }
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        HStack {
            StatusCard(
                title: "Status",
                value: "Normal",
                icon: "checkmark.circle.fill",
                color: .green
            )
            
            StatusCard(
                title: "Zone",
                value: "Active",
                icon: "target",
                color: .blue
            )
        }
        .padding()
    }
}
*/
