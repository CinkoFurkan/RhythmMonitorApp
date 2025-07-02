//
//  AnalyticsView.swift
//  RhythmMonitorApp
//
//  Created by Furkan Cinko on 31.05.2025.
//

/*import SwiftUI

struct AnalyticsView: View {
    @ObservedObject var viewModel: HeartbeatViewModel
    @State private var selectedTimeRange: TimeRange = .today
    @State private var showingDetails = false
    
    enum TimeRange: String, CaseIterable {
        case today = "Today"
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Header with time range selector
                    VStack(spacing: 15) {
                        Text("Analytics")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        // Time Range Picker
                        Picker("Time Range", selection: $selectedTimeRange) {
                            ForEach(TimeRange.allCases, id: \.self) { range in
                                Text(range.rawValue).tag(range)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Heart Rate Chart Section
                    VStack(spacing: 15) {
                        HStack {
                            Text("Heart Rate Trend")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Button("Details") {
                                showingDetails.toggle()
                            }
                            .foregroundColor(.blue)
                            .font(.subheadline)
                        }
                        
                        HeartRateChart(
                            data: viewModel.chartData,
                            timeRange: selectedTimeRange
                        )
                    }
                    .padding(.horizontal)
                    
                    // Summary Statistics
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Summary Statistics")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 15) {
                            SummaryCard(
                                title: "Average BPM",
                                value: "\(viewModel.averageHeartRate)",
                                subtitle: "Normal range",
                                color: .green,
                                trend: .stable
                            )
                            
                            SummaryCard(
                                title: "Maximum BPM",
                                value: "\(viewModel.maxHeartRate)",
                                subtitle: "Peak today",
                                color: .red,
                                trend: .up
                            )
                            
                            SummaryCard(
                                title: "Minimum BPM",
                                value: "\(viewModel.minHeartRate)",
                                subtitle: "Resting rate",
                                color: .blue,
                                trend: .down
                            )
                            
                            SummaryCard(
                                title: "Sessions",
                                value: "\(viewModel.totalSessions)",
                                subtitle: "This \(selectedTimeRange.rawValue.lowercased())",
                                color: .purple,
                                trend: .stable
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    // Heart Rate Zones
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Heart Rate Zones")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            HeartRateZoneRow(
                                zone: "Resting Zone",
                                range: "< 60 BPM",
                                percentage: viewModel.restingZonePercentage,
                                color: .blue
                            )
                            
                            HeartRateZoneRow(
                                zone: "Active Zone",
                                range: "60-100 BPM",
                                percentage: viewModel.activeZonePercentage,
                                color: .green
                            )
                            
                            HeartRateZoneRow(
                                zone: "Aerobic Zone",
                                range: "100-140 BPM",
                                percentage: viewModel.aerobicZonePercentage,
                                color: .orange
                            )
                            
                            HeartRateZoneRow(
                                zone: "Peak Zone",
                                range: "> 140 BPM",
                                percentage: viewModel.peakZonePercentage,
                                color: .red
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    // Weekly Goals Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Weekly Goals")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        WeeklyGoalsCard(
                            activeMinutes: viewModel.weeklyActiveMinutes,
                            goal: 150,
                            streakDays: viewModel.streakDays
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 30)
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingDetails) {
            HeartRateDetailsView(viewModel: viewModel)
        }
    }
}

// MARK: - Heart Rate Zone Row
struct HeartRateZoneRow: View {
    let zone: String
    let range: String
    let percentage: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(zone)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(Int(percentage))%")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
            }
            
            Text(range)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.white.opacity(0.1))
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * (percentage / 100))
                        .cornerRadius(4)
                        .animation(.easeInOut(duration: 1.0), value: percentage)
                }
            }
            .frame(height: 8)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

// MARK: - Weekly Goals Card
struct WeeklyGoalsCard: View {
    let activeMinutes: Int
    let goal: Int
    let streakDays: Int
    
    private var progress: Double {
        Double(activeMinutes) / Double(goal)
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Active Minutes")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("\(activeMinutes) / \(goal) min")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                VStack {
                    Text("\(streakDays)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    
                    Text("Day Streak")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            
            // Progress visualization
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 8)
                
                Circle()
                    .trim(from: 0, to: min(progress, 1.0))
                    .stroke(
                        LinearGradient(
                            colors: [.green, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.5), value: progress)
                
                VStack {
                    Text("\(Int(progress * 100))%")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Complete")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .frame(width: 120, height: 120)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.green.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

// MARK: - Heart Rate Details View
struct HeartRateDetailsView: View {
    @ObservedObject var viewModel: HeartbeatViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Detailed Analytics")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Add more detailed charts and analytics here
                    Text("Detailed charts and analytics will be displayed here")
                        .foregroundColor(.secondary)
                        .padding()
                    
                    Spacer()
                }
            }
            .navigationTitle("Heart Rate Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
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
        
        AnalyticsView(viewModel: HeartbeatViewModel())
    }
}
*/
