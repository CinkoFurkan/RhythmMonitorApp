//
//  HeartRateChart.swift
//  RhythmMonitorApp
//
//  Created by Furkan Cinko on 31.05.2025.
//

/*import SwiftUI

struct HeartRateChart: View {
    let data: [HeartbeatData]
    let timeRange: AnalyticsView.TimeRange
    @State private var animationProgress: CGFloat = 0
    @State private var selectedPoint: HeartbeatData?
    
    var body: some View {
        VStack(spacing: 15) {
            // Chart container
            ZStack {
                // Background gradient
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.1),
                                Color.white.opacity(0.05)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                
                VStack {
                    // Chart header with current selection info
                    if let selectedPoint = selectedPoint {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(selectedPoint.heartbeat) BPM")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text(selectedPoint.timestamp, formatter: timeFormatter)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            Button("Clear") {
                                selectedPoint = nil
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    
                    // Chart area
                    GeometryReader { geometry in
                        ZStack {
                            // Grid lines
                            ChartGridLines(geometry: geometry)
                            
                            // Heart rate zones background
                            HeartRateZonesBackground(geometry: geometry)
                            
                            // Chart line and points
                            ChartLineView(
                                data: data,
                                geometry: geometry,
                                animationProgress: animationProgress,
                                selectedPoint: $selectedPoint
                            )
                        }
                    }
                    .frame(height: 200)
                    .padding()
                    
                    // Chart legend
                    ChartLegend()
                        .padding(.bottom)
                }
            }
            .frame(height: 280)
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0)) {
                    animationProgress = 1.0
                }
            }
        }
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        switch timeRange {
        case .today:
            formatter.timeStyle = .short
        case .week:
            formatter.dateFormat = "E, MMM d"
        case .month:
            formatter.dateFormat = "MMM d"
        case .year:
            formatter.dateFormat = "MMM yyyy"
        }
        return formatter
    }
}

// MARK: - Chart Grid Lines
struct ChartGridLines: View {
    let geometry: GeometryProxy
    
    var body: some View {
        ZStack {
            // Horizontal grid lines
            ForEach(0..<5) { i in
                Path { path in
                    let y = geometry.size.height * CGFloat(i) / 4
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                }
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
            }
            
            // Vertical grid lines
            ForEach(0..<7) { i in
                Path { path in
                    let x = geometry.size.width * CGFloat(i) / 6
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                }
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
            }
        }
    }
}

// MARK: - Heart Rate Zones Background
struct HeartRateZonesBackground: View {
    let geometry: GeometryProxy
    
    var body: some View {
        ZStack {
            // Peak zone (>140 BPM) - Red
            Rectangle()
                .fill(Color.red.opacity(0.1))
                .frame(height: geometry.size.height * 0.2)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height * 0.1
                )
            
            // Aerobic zone (100-140 BPM) - Orange
            Rectangle()
                .fill(Color.orange.opacity(0.1))
                .frame(height: geometry.size.height * 0.3)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height * 0.35
                )
            
            // Active zone (60-100 BPM) - Green
            Rectangle()
                .fill(Color.green.opacity(0.1))
                .frame(height: geometry.size.height * 0.3)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height * 0.65
                )
            
            // Resting zone (<60 BPM) - Blue
            Rectangle()
                .fill(Color.blue.opacity(0.1))
                .frame(height: geometry.size.height * 0.2)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height * 0.9
                )
        }
    }
}

// MARK: - Chart Line View
struct ChartLineView: View {
    let data: [HeartbeatData]
    let geometry: GeometryProxy
    let animationProgress: CGFloat
    @Binding var selectedPoint: HeartbeatData?
    
    private let minHeartRate: CGFloat = 40
    private let maxHeartRate: CGFloat = 180
    
    var body: some View {
        ZStack {
            // Chart line
            if data.count > 1 {
                Path { path in
                    let points = dataPoints
                    if let firstPoint = points.first {
                        path.move(to: firstPoint)
                        for point in points.dropFirst() {
                            path.addLine(to: point)
                        }
                    }
                }
                .trim(from: 0, to: animationProgress)
                .stroke(
                    LinearGradient(
                        colors: [.green, .blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                )
                .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 2)
                
                // Gradient fill under the line
                Path { path in
                    let points = dataPoints
                    if let firstPoint = points.first {
                        path.move(to: CGPoint(x: firstPoint.x, y: geometry.size.height))
                        path.addLine(to: firstPoint)
                        for point in points.dropFirst() {
                            path.addLine(to: point)
                        }
                        if let lastPoint = points.last {
                            path.addLine(to: CGPoint(x: lastPoint.x, y: geometry.size.height))
                        }
                        path.closeSubpath()
                    }
                }
                .trim(from: 0, to: animationProgress)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.green.opacity(0.3),
                            Color.blue.opacity(0.1),
                            Color.clear
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            
            // Data points
            ForEach(Array(data.enumerated()), id: \.element.id) { index, dataPoint in
                let point = dataPointPosition(for: dataPoint, at: index)
                
                Circle()
                    .fill(heartRateColor(for: dataPoint.heartbeat))
                    .frame(width: selectedPoint?.id == dataPoint.id ? 12 : 8)
                    .position(point)
                    .shadow(color: heartRateColor(for: dataPoint.heartbeat).opacity(0.5), radius: 3)
                    .scaleEffect(selectedPoint?.id == dataPoint.id ? 1.2 : 1.0)
                    .animation(.spring(response: 0.3), value: selectedPoint?.id)
                    .onTapGesture {
                        selectedPoint = dataPoint
                    }
                    .opacity(animationProgress > CGFloat(index) / CGFloat(data.count) ? 1 : 0)
            }
        }
    }
    
    private var dataPoints: [CGPoint] {
        return data.enumerated().map { index, dataPoint in
            dataPointPosition(for: dataPoint, at: index)
        }
    }
    
    private func dataPointPosition(for dataPoint: HeartbeatData, at index: Int) -> CGPoint {
        let x = geometry.size.width * CGFloat(index) / CGFloat(max(data.count - 1, 1))
        let normalizedHeartRate = (CGFloat(dataPoint.heartbeat) - minHeartRate) / (maxHeartRate - minHeartRate)
        let y = geometry.size.height * (1 - normalizedHeartRate)
        return CGPoint(x: x, y: max(0, min(geometry.size.height, y)))
    }
    
    private func heartRateColor(for heartRate: Int) -> Color {
        switch heartRate {
        case 0..<60: return .blue
        case 60..<100: return .green
        case 100..<140: return .orange
        default: return .red
        }
    }
}

// MARK: - Chart Legend
struct ChartLegend: View {
    var body: some View {
        HStack(spacing: 20) {
            LegendItem(color: .blue, text: "Rest")
            LegendItem(color: .green, text: "Active")
            LegendItem(color: .orange, text: "Aerobic")
            LegendItem(color: .red, text: "Peak")
        }
    }
}

struct LegendItem: View {
    let color: Color
    let text: String
    
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        HeartRateChart(
            data: HeartbeatViewModel().chartData,
            timeRange: .today
        )
        .padding()
*/
