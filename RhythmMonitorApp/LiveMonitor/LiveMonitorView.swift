//
//  LiveMonitorView.swift
//  RhythmMonitorApp
//
//  Created by Furkan Cinko on 31.05.2025.
//

/*import SwiftUI

struct LiveMonitorView: View {
    @ObservedObject var viewModel: HeartbeatViewModel
    @State private var pulseScale: CGFloat = 1.0
    @State private var isRecording = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                Text("Rhythm24 Monitor")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                // Heart Rate Display
                HeartRateDisplay(
                    heartbeat: viewModel.heartbeat,
                    pulseScale: $pulseScale
                )
                .onAppear {
                    startHeartAnimation()
                }
                
                // Status Cards
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    StatusCard(
                        title: "Status",
                        value: heartRateStatus,
                        icon: "checkmark.circle.fill",
                        color: statusColor
                    )
                    
                    StatusCard(
                        title: "Zone",
                        value: heartRateZone,
                        icon: "target",
                        color: zoneColor
                    )
                    
                    StatusCard(
                        title: "Session",
                        value: sessionDuration,
                        icon: "timer",
                        color: .blue
                    )
                    
                    StatusCard(
                        title: "Avg BPM",
                        value: "\(viewModel.averageHeartRate)",
                        icon: "chart.bar.fill",
                        color: .purple
                    )
                }
                .padding(.horizontal)
                
                // Control Buttons
                ControlButtonsView(isRecording: $isRecording)
                    .padding(.bottom, 30)
            }
        }
    }
    
    // MARK: - Private Methods
    private func startHeartAnimation() {
        withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
            pulseScale = 1.2
        }
    }
    
    // MARK: - Computed Properties
    private var heartRateStatus: String {
        HeartRateHelper.getStatus(for: viewModel.heartbeat)
    }
    
    private var statusColor: Color {
        HeartRateHelper.getStatusColor(for: viewModel.heartbeat)
    }
    
    private var heartRateZone: String {
        HeartRateHelper.getZone(for: viewModel.heartbeat)
    }
    
    private var zoneColor: Color {
        HeartRateHelper.getZoneColor(for: viewModel.heartbeat)
    }
    
    private var sessionDuration: String {
        // This would be calculated based on actual session time
        return "12:34"
    }
}

// MARK: - Heart Rate Display Component
struct HeartRateDisplay: View {
    let heartbeat: Int
    @Binding var pulseScale: CGFloat
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                // Animated pulse rings
                ForEach(0..<3) { i in
                    Circle()
                        .stroke(Color.red.opacity(0.3), lineWidth: 2)
                        .scaleEffect(pulseScale + CGFloat(i) * 0.2)
                        .opacity(1.0 - (pulseScale - 1.0) - CGFloat(i) * 0.2)
                }
                
                // Heart icon
                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
                    .scaleEffect(pulseScale)
            }
            .frame(width: 120, height: 120)
            
            // BPM Display
            Text("\(heartbeat)")
                .font(.system(size: 72, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            Text("BPM")
                .font(.title2)
                .foregroundColor(.white.opacity(0.8))
                .fontWeight(.medium)
        }
        .padding(.vertical, 20)
    }
}

// MARK: - Control Buttons Component
struct ControlButtonsView: View {
    @Binding var isRecording: Bool
    
    var body: some View {
        HStack(spacing: 30) {
            ControlButton(
                icon: isRecording ? "stop.circle.fill" : "record.circle",
                title: isRecording ? "Stop" : "Record",
                color: isRecording ? .red : .white
            ) {
                isRecording.toggle()
                // Add recording logic here
            }
            
            ControlButton(
                icon: "square.and.arrow.down",
                title: "Save",
                color: .white
            ) {
                // Add save logic here
            }
            
            ControlButton(
                icon: "square.and.arrow.up",
                title: "Share",
                color: .white
            ) {
                // Add share logic here
            }
        }
    }
}

// MARK: - Individual Control Button
struct ControlButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 30))
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(color)
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(15)
        }
    }
}

// MARK: - Heart Rate Helper
struct HeartRateHelper {
    static func getStatus(for heartRate: Int) -> String {
        switch heartRate {
        case 0..<60: return "Low"
        case 60..<100: return "Normal"
        case 100..<120: return "Elevated"
        default: return "High"
        }
    }
    
    static func getStatusColor(for heartRate: Int) -> Color {
        switch heartRate {
        case 0..<60: return .blue
        case 60..<100: return .green
        case 100..<120: return .orange
        default: return .red
        }
    }
    
    static func getZone(for heartRate: Int) -> String {
        switch heartRate {
        case 0..<60: return "Rest"
        case 60..<100: return "Active"
        case 100..<140: return "Aerobic"
        default: return "Peak"
        }
    }
    
    static func getZoneColor(for heartRate: Int) -> Color {
        switch heartRate {
        case 0..<60: return .cyan
        case 60..<100: return .green
        case 100..<140: return .yellow
        default: return .red
        }
    }
}*/
