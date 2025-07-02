//
//  HeartRateDisplay.swift
//  RhythmMonitorApp
//
//  Created by Furkan Cinko on 31.05.2025.
//

/*import SwiftUI

struct HeartRateDisplay: View {
    let heartbeat: Int
    @Binding var pulseScale: CGFloat
    @State private var ringOpacity: Double = 1.0
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                // Animated pulse rings
                ForEach(0..<3) { i in
                    Circle()
                        .stroke(
                            heartRateColor.opacity(0.4 - Double(i) * 0.1),
                            lineWidth: 3 - CGFloat(i) * 0.5
                        )
                        .scaleEffect(pulseScale + CGFloat(i) * 0.3)
                        .opacity(ringOpacity - Double(i) * 0.2)
                        .animation(
                            .easeInOut(duration: 1.0 + Double(i) * 0.2)
                            .repeatForever(autoreverses: false),
                            value: pulseScale
                        )
                }
                
                // Heart icon with gradient
                Image(systemName: "heart.fill")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [heartRateColor, heartRateColor.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .scaleEffect(pulseScale)
                    .shadow(color: heartRateColor.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            .frame(width: 140, height: 140)
            
            // BPM Display with animated counter
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text("\(heartbeat)")
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    .contentTransition(.numericText())
                    .animation(.bouncy(duration: 0.5), value: heartbeat)
                
                Text("BPM")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
                    .fontWeight(.medium)
                    .offset(y: -10)
            }
            
            // Heart rate status indicator
            HStack(spacing: 8) {
                Circle()
                    .fill(heartRateColor)
                    .frame(width: 12, height: 12)
                    .shadow(color: heartRateColor.opacity(0.5), radius: 3)
                
                Text(heartRateStatus)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        Capsule()
                            .stroke(heartRateColor.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .padding(.vertical, 20)
        .onAppear {
            startPulseAnimation()
        }
    }
    
    // MARK: - Private Methods
    private func startPulseAnimation() {
        withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
            pulseScale = 1.15
        }
        
        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
            ringOpacity = 0.2
        }
    }
    
    // MARK: - Computed Properties
    private var heartRateColor: Color {
        switch heartbeat {
        case 0..<60: return .blue
        case 60..<100: return .green
        case 100..<120: return .orange
        default: return .red
        }
    }
    
    private var heartRateStatus: String {
        switch heartbeat {
        case 0..<60: return "Resting"
        case 60..<100: return "Normal"
        case 100..<120: return "Elevated"
        default: return "High"
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.black, .gray.opacity(0.8)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        
        HeartRateDisplay(
            heartbeat: 78,
            pulseScale: .constant(1.0)
        )
    }
}
*/
