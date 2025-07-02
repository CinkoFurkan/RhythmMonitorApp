//
//  ContentView.swift
//  RhythmMonitorApp
//
//  Created by Furkan Cinko on 31.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HeartbeatViewModel()
    @State private var selectedTab = 0
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Dynamic gradient background that changes based on heart rate
            LinearGradient(
                colors: backgroundColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 2.0), value: viewModel.heartbeat)
            
            TabView(selection: $selectedTab) {
                // Tab 1: Live Monitor
                LiveMonitorView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "heart.fill" : "heart")
                        Text("Live")
                    }
                    .tag(0)
                
                // Tab 2: Data Collection (NEW)
                DataCollectionView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: selectedTab == 1 ? "doc.text.fill" : "doc.text")
                        Text("Collect")
                    }
                    .tag(1)
                
                // Tab 3: Analytics
                AnalyticsView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: selectedTab == 2 ? "chart.line.uptrend.xyaxis" : "chart.line.uptrend.xyaxis")
                        Text("Analytics")
                    }
                    .tag(2)
                
                // Tab 4: History
                HistoryView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: selectedTab == 3 ? "clock.fill" : "clock")
                        Text("History")
                    }
                    .tag(3)
                
                // Tab 5: Profile
                ProfileView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        Text("Profile")
                    }
                    .tag(4)
            }
            .accentColor(.white)
        }
        .preferredColorScheme(.dark)
    }
    
    // Dynamic background colors based on heart rate
    private var backgroundColors: [Color] {
        let heartRate = viewModel.heartbeat
        switch heartRate {
        case 0..<60:
            return [.blue.opacity(0.8), .purple.opacity(0.6), .black]
        case 60..<100:
            return [.green.opacity(0.7), .teal.opacity(0.5), .black]
        case 100..<120:
            return [.yellow.opacity(0.6), .orange.opacity(0.4), .black]
        default:
            return [.red.opacity(0.7), .pink.opacity(0.5), .black]
        }
    }
}

// MARK: - Data Collection View
struct DataCollectionView: View {
    @ObservedObject var viewModel: HeartbeatViewModel
    @State private var isCollecting = false
    @State private var countdown = 60
    @State private var collectedData: [HeartbeatData] = []
    @State private var timer: Timer? = nil
    @State private var showingShareSheet = false
    @State private var csvURL: URL? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                Text("Data Collection")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                // Instructions
                VStack(spacing: 15) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    Text("Collect heart rate data for research or analysis")
                        .font(.title3)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Data will be collected every second for 60 seconds and saved as a CSV file")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.vertical, 20)
                
                // Status Display
                VStack(spacing: 20) {
                    if isCollecting {
                        // Countdown Display
                        VStack(spacing: 10) {
                            Text("Collecting Data...")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            ZStack {
                                Circle()
                                    .stroke(Color.white.opacity(0.3), lineWidth: 8)
                                    .frame(width: 120, height: 120)
                                
                                Circle()
                                    .trim(from: 0, to: CGFloat(60 - countdown) / 60)
                                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                    .frame(width: 120, height: 120)
                                    .rotationEffect(.degrees(-90))
                                    .animation(.linear(duration: 1), value: countdown)
                                
                                VStack {
                                    Text("\(countdown)")
                                        .font(.system(size: 36, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("seconds")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                            }
                            
                            Text("Collected: \(collectedData.count) entries")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    } else {
                        // Collection Status
                        VStack(spacing: 15) {
                            StatusCard(
                                title: "Last Collection",
                                value: collectedData.isEmpty ? "None" : "\(collectedData.count) entries",
                                icon: "chart.bar.doc.horizontal",
                                color: collectedData.isEmpty ? .gray : .green
                            )
                            
                            if !collectedData.isEmpty {
                                HStack {
                                    VStack {
                                        Text("Duration")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.7))
                                        Text("60s")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("Avg BPM")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.7))
                                        Text("\(averageBPM)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("Range")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.7))
                                        Text("\(minBPM)-\(maxBPM)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(15)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Control Buttons
                VStack(spacing: 20) {
                    Button(action: {
                        if !isCollecting {
                            startDataCollection()
                        }
                    }) {
                        HStack {
                            Image(systemName: isCollecting ? "stop.circle.fill" : "play.circle.fill")
                                .font(.title2)
                            Text(isCollecting ? "Collecting Data..." : "Start Collection")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: isCollecting ? [.gray.opacity(0.6), .gray.opacity(0.4)] : [.blue.opacity(0.8), .blue.opacity(0.6)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .disabled(isCollecting)
                    
                    if !isCollecting && !collectedData.isEmpty {
                        Button(action: {
                            shareCSVFile()
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title2)
                                Text("Share CSV File")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.green.opacity(0.8), .green.opacity(0.6)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                        
                        Button(action: {
                            collectedData.removeAll()
                        }) {
                            HStack {
                                Image(systemName: "trash")
                                    .font(.title2)
                                Text("Clear Data")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.6))
                            .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            if let url = csvURL {
                ShareSheet(activityItems: [url])
            }
        }
    }
    
    private var averageBPM: Int {
        guard !collectedData.isEmpty else { return 0 }
        return collectedData.reduce(0) { $0 + $1.heartbeat } / collectedData.count
    }
    
    private var minBPM: Int {
        collectedData.min(by: { $0.heartbeat < $1.heartbeat })?.heartbeat ?? 0
    }
    
    private var maxBPM: Int {
        collectedData.max(by: { $0.heartbeat < $1.heartbeat })?.heartbeat ?? 0
    }
    
    func startDataCollection() {
        isCollecting = true
        countdown = 60
        collectedData.removeAll()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if countdown > 0 {
                let newData = HeartbeatData(id: UUID(), timestamp: Date(), heartbeat: viewModel.heartbeat)
                collectedData.append(newData)
                countdown -= 1
            } else {
                timer?.invalidate()
                timer = nil
                isCollecting = false
                saveDataToCSV()
            }
        }
    }
    
    func saveDataToCSV() {
        for data in collectedData {
            viewModel.writeToCSV(heartbeatData: data)
        }
        print("Data saved to CSV.")
    }
    
    func shareCSVFile() {
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = paths[0].appendingPathComponent("heartbeat_data.csv")
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("CSV file not found!")
            return
        }
        
        csvURL = fileURL
        showingShareSheet = true
    }
}

// MARK: - Share Sheet
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

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
                    .onAppear {
                        startHeartAnimation()
                    }
                    
                    // BPM Display
                    Text("\(viewModel.heartbeat)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    Text("BPM")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.8))
                        .fontWeight(.medium)
                }
                .padding(.vertical, 20)
                
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
                HStack(spacing: 30) {
                    Button(action: {
                        isRecording.toggle()
                        // Add recording logic here
                    }) {
                        VStack {
                            Image(systemName: isRecording ? "stop.circle.fill" : "record.circle")
                                .font(.system(size: 30))
                            Text(isRecording ? "Stop" : "Record")
                                .font(.caption)
                        }
                        .foregroundColor(isRecording ? .red : .white)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                    }
                    
                    Button(action: {
                        // Add save logic here
                    }) {
                        VStack {
                            Image(systemName: "square.and.arrow.down")
                                .font(.system(size: 30))
                            Text("Save")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                    }
                    
                    Button(action: {
                        // Add share logic here
                    }) {
                        VStack {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 30))
                            Text("Share")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                    }
                }
                .padding(.bottom, 30)
            }
        }
    }
    
    private func startHeartAnimation() {
        withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
            pulseScale = 1.2
        }
    }
    
    private var heartRateStatus: String {
        let hr = viewModel.heartbeat
        switch hr {
        case 0..<60: return "Low"
        case 60..<100: return "Normal"
        case 100..<120: return "Elevated"
        default: return "High"
        }
    }
    
    private var statusColor: Color {
        let hr = viewModel.heartbeat
        switch hr {
        case 0..<60: return .blue
        case 60..<100: return .green
        case 100..<120: return .orange
        default: return .red
        }
    }
    
    private var heartRateZone: String {
        let hr = viewModel.heartbeat
        switch hr {
        case 0..<60: return "Rest"
        case 60..<100: return "Active"
        case 100..<140: return "Aerobic"
        default: return "Peak"
        }
    }
    
    private var zoneColor: Color {
        let hr = viewModel.heartbeat
        switch hr {
        case 0..<60: return .cyan
        case 60..<100: return .green
        case 100..<140: return .yellow
        default: return .red
        }
    }
    
    private var sessionDuration: String {
        // This would be calculated based on actual session time
        return "12:34"
    }
}

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
                Spacer()
            }
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
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
    }
}

struct AnalyticsView: View {
    @ObservedObject var viewModel: HeartbeatViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Analytics")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                
                // Placeholder for charts
                VStack(spacing: 15) {
                    Text("Heart Rate Trend")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 200)
                        .overlay(
                            Text("Chart will be displayed here")
                                .foregroundColor(.white.opacity(0.6))
                        )
                }
                .padding(.horizontal)
                
                // Weekly Summary
                VStack(alignment: .leading, spacing: 10) {
                    Text("Weekly Summary")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        SummaryCard(title: "Avg BPM", value: "78", color: .green)
                        SummaryCard(title: "Max BPM", value: "142", color: .red)
                        SummaryCard(title: "Min BPM", value: "54", color: .blue)
                        SummaryCard(title: "Sessions", value: "12", color: .purple)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SummaryCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
    }
}

struct HistoryView: View {
    @ObservedObject var viewModel: HeartbeatViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.data) { data in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(data.heartbeat) BPM")
                            .font(.headline)
                        Text(data.timestamp, formatter: dateFormatter)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .foregroundColor(heartRateColor(data.heartbeat))
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func heartRateColor(_ heartRate: Int) -> Color {
        switch heartRate {
        case 0..<60: return .blue
        case 60..<100: return .green
        case 100..<120: return .orange
        default: return .red
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

struct ProfileView: View {
    @ObservedObject var viewModel: HeartbeatViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Profile Header
                VStack(spacing: 15) {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        )
                    
                    Text("User Profile")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                // Settings List
                VStack(spacing: 15) {
                    SettingsRow(icon: "gear", title: "Settings", action: {})
                    SettingsRow(icon: "bell", title: "Notifications", action: {})
                    SettingsRow(icon: "heart.text.square", title: "Health Data", action: {})
                    SettingsRow(icon: "info.circle", title: "About", action: {})
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .frame(width: 30)
                
                Text(title)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.6))
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

// MARK: - HeartbeatViewModel (Enhanced)
class HeartbeatViewModel: ObservableObject {
    @Published var heartbeat: Int = 78
    @Published var data: [HeartbeatData] = []
    
    var averageHeartRate: Int {
        guard !data.isEmpty else { return heartbeat }
        return data.reduce(0) { $0 + $1.heartbeat } / data.count
    }
    
    init() {
        // Generate some sample data
        generateSampleData()
        // Start simulating heart rate changes
        startHeartRateSimulation()
    }
    
    private func generateSampleData() {
        let calendar = Calendar.current
        for i in 0..<20 {
            let date = calendar.date(byAdding: .minute, value: -i * 5, to: Date()) ?? Date()
            let heartRate = Int.random(in: 65...95)
            data.append(HeartbeatData(id: UUID(), timestamp: date, heartbeat: heartRate))
        }
    }
    
    private func startHeartRateSimulation() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            // Simulate realistic heart rate changes
            let change = Int.random(in: -3...3)
            let newRate = max(50, min(180, self.heartbeat + change))
            self.heartbeat = newRate
        }
    }
    
    func writeToCSV(heartbeatData: HeartbeatData) {
        let fileName = "heartbeat_data.csv"
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = paths[0].appendingPathComponent(fileName)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let csvLine = "\(dateFormatter.string(from: heartbeatData.timestamp)),\(heartbeatData.heartbeat)\n"
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            // Create file with header
            let header = "Timestamp,HeartRate\n"
            try? header.write(to: fileURL, atomically: true, encoding: .utf8)
        }
        
        // Append data
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(csvLine.data(using: .utf8)!)
            fileHandle.closeFile()
        }
    }
}

struct HeartbeatData: Identifiable {
    let id: UUID
    let timestamp: Date
    let heartbeat: Int
}

#Preview {
    ContentView()
}
