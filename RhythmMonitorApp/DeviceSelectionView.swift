//
//  DeviceSelectionView.swift
//  RhythmMonitorApp
//
//  Created by Furkan Cinko on 31.05.2025.
//

import SwiftUI
import CoreBluetooth

struct DeviceSelectionView: View {
    @StateObject var bluetoothManager = BluetoothManager()
    @State private var selectedPeripheral: CBPeripheral? = nil
    @State private var isTestDeviceSelected: Bool = true
    @State private var isScanning: Bool = false
    @State private var showingPermissionAlert: Bool = false
    @State private var pulseAnimation: Bool = false
    @State private var backgroundScale: CGFloat = 1.0
    @State private var animateContent = false
    
    var body: some View {
        ZStack {
            // Animated background matching welcome page
            Color.black
                .ignoresSafeArea()
            
            // Dynamic gradient overlay
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.green.opacity(0.3), location: 0.0),
                    .init(color: Color.black.opacity(0.8), location: 0.4),
                    .init(color: Color.mint.opacity(0.2), location: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .scaleEffect(backgroundScale)
            .animation(.easeInOut(duration: 20).repeatForever(autoreverses: true), value: backgroundScale)
            
            // Animated particles effect
            DeviceParticleEffectView()
            
            ScrollView {
                VStack(spacing: 32) {
                    // Header Section with pulsing heart
                    VStack(spacing: 24) {
                        ZStack {
                            // Outer pulse ring
                            Circle()
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color.green.opacity(0.4), Color.clear]),
                                        center: .center,
                                        startRadius: 10,
                                        endRadius: 100
                                    )
                                )
                                .frame(width: 140, height: 140)
                                .scaleEffect(pulseAnimation ? 1.3 : 0.9)
                                .opacity(pulseAnimation ? 0.6 : 0.3)
                                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: pulseAnimation)
                            
                            // Inner circle
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.green.opacity(0.3), .mint.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Circle()
                                        .stroke(Color.green.opacity(0.5), lineWidth: 2)
                                )
                                .scaleEffect(pulseAnimation ? 1.1 : 1.0)
                                .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulseAnimation)
                            
                            Image(systemName: "sensor.tag.radiowaves.forward.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.white, .green.opacity(0.8)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .shadow(color: .green, radius: 10)
                        }
                        .offset(y: animateContent ? 0 : -30)
                        .opacity(animateContent ? 1 : 0)
                        
                        VStack(spacing: 8) {
                            Text("Device Connection")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.white, .green.opacity(0.8)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: .green.opacity(0.6), radius: 15, x: 0, y: 8)
                            
                            Text("Connect your Rhythm24 device")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                                .fontWeight(.medium)
                        }
                        .offset(y: animateContent ? 0 : 20)
                        .opacity(animateContent ? 1 : 0)
                    }
                    .padding(.top, 40)
                    
                    // Connection Status
                    ConnectionStatusView(
                        status: bluetoothManager.connectionStatus,
                        isScanning: isScanning
                    )
                    .offset(y: animateContent ? 0 : 30)
                    .opacity(animateContent ? 1 : 0)
                    
                    // Bluetooth Instructions
                    InstructionCard()
                        .offset(y: animateContent ? 0 : 40)
                        .opacity(animateContent ? 1 : 0)
                    
                    // Device Selection Section
                    VStack(spacing: 20) {
                        HStack {
                            Text("Available Devices")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.white, .green.opacity(0.8)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    isScanning = true
                                    bluetoothManager.startScanning()
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        isScanning = false
                                    }
                                }
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "arrow.clockwise")
                                        .rotationEffect(.degrees(isScanning ? 360 : 0))
                                        .animation(.linear(duration: 1).repeatCount(isScanning ? .max : 0), value: isScanning)
                                    Text("Scan")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.ultraThinMaterial)
                                            .environment(\.colorScheme, .dark)
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [.green.opacity(0.6), .mint.opacity(0.4)],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 1
                                            )
                                    }
                                )
                                .shadow(color: .green.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            // Test Device Card
                            EnhancedDeviceCard(
                                name: "Test Device",
                                subtitle: "For testing purposes",
                                icon: "laptopcomputer",
                                isSelected: isTestDeviceSelected,
                                isTestDevice: true,
                                signalStrength: 5
                            ) {
                                withAnimation(.spring()) {
                                    selectedPeripheral = nil
                                    isTestDeviceSelected = true
                                }
                            }
                            
                            // Real Devices
                            ForEach(bluetoothManager.devices, id: \.identifier) { device in
                                EnhancedDeviceCard(
                                    name: device.name ?? "Unknown Device",
                                    subtitle: "Bluetooth Device",
                                    icon: "sensor.tag.radiowaves.forward",
                                    isSelected: selectedPeripheral?.identifier == device.identifier,
                                    isTestDevice: false,
                                    signalStrength: Int.random(in: 2...5)
                                ) {
                                    withAnimation(.spring()) {
                                        selectedPeripheral = device
                                        isTestDeviceSelected = false
                                    }
                                }
                            }
                            
                            // No devices found message
                            if bluetoothManager.devices.isEmpty && !isScanning {
                                NoDevicesFoundCard()
                            }
                        }
                        .padding(.horizontal)
                    }
                    .offset(y: animateContent ? 0 : 50)
                    .opacity(animateContent ? 1 : 0)
                    
                    // Connect Button
                    ConnectButton(
                        bluetoothManager: bluetoothManager,
                        isTestDeviceSelected: isTestDeviceSelected,
                        selectedPeripheral: selectedPeripheral,
                        isScanning: $isScanning
                    )
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                    .offset(y: animateContent ? 0 : 60)
                    .opacity(animateContent ? 1 : 0)
                }
            }
            
            // Navigation Link
            NavigationLink(
                destination: ContentView(),
                isActive: $bluetoothManager.isConnected
            ) {
                EmptyView()
            }
            .hidden()
        }
        .onAppear {
            startAnimations()
            bluetoothManager.startScanning()
        }
        .navigationBarHidden(true)
        .alert("Bluetooth Permission Required", isPresented: $showingPermissionAlert) {
            Button("Settings") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please enable Bluetooth permission in Settings to connect to your device.")
        }
        .preferredColorScheme(.dark)
    }
    
    private func startAnimations() {
        backgroundScale = 1.1
        
        withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
            animateContent = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            pulseAnimation = true
        }
    }
}

struct ConnectionStatusView: View {
    let status: String
    let isScanning: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            // Status Icon with glow effect
            ZStack {
                Circle()
                    .fill(statusColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: statusIcon)
                    .foregroundColor(statusColor)
                    .font(.title3)
                    .shadow(color: statusColor.opacity(0.8), radius: 5)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(displayStatus)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                if !status.isEmpty && status != "Disconnected" {
                    Text(status)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            
            Spacer()
            
            if isScanning {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
                    .scaleEffect(0.9)
            }
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            colors: [statusColor.opacity(0.6), statusColor.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
        )
        .shadow(color: statusColor.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
    private var statusIcon: String {
        switch status {
        case "Connected":
            return "checkmark.circle.fill"
        case "Connecting...":
            return "antenna.radiowaves.left.and.right"
        default:
            return "bluetooth"
        }
    }
    
    private var statusColor: Color {
        switch status {
        case "Connected":
            return .green
        case "Connecting...":
            return .orange
        default:
            return .mint
        }
    }
    
    private var displayStatus: String {
        if isScanning {
            return "Scanning for devices..."
        } else if status.isEmpty || status == "Disconnected" {
            return "Ready to connect"
        } else {
            return status
        }
    }
}

struct InstructionCard: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.2))
                        .frame(width: 30, height: 30)
                    
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.green)
                        .font(.title3)
                }
                
                Text("Quick Setup Guide")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, .green.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 12) {
                InstructionStep(number: "1", text: "Make sure Bluetooth is enabled")
                InstructionStep(number: "2", text: "Turn on your Rhythm24 device")
                InstructionStep(number: "3", text: "Select your device from the list")
                InstructionStep(number: "4", text: "Tap Connect to start monitoring")
            }
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            colors: [.green.opacity(0.4), .mint.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
        )
        .shadow(color: .green.opacity(0.2), radius: 15, x: 0, y: 8)
        .padding(.horizontal)
    }
}

struct InstructionStep: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Text(number)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.green.opacity(0.8), .mint.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .shadow(color: .green.opacity(0.4), radius: 3)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            
            Spacer()
        }
    }
}

struct EnhancedDeviceCard: View {
    let name: String
    let subtitle: String
    let icon: String
    let isSelected: Bool
    let isTestDevice: Bool
    let signalStrength: Int
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 16) {
                // Device Icon
                ZStack {
                    Circle()
                        .fill(
                            isSelected ?
                            LinearGradient(colors: [.green.opacity(0.3), .mint.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing) :
                            LinearGradient(colors: [.white.opacity(0.1), .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: 55, height: 55)
                        .overlay(
                            Circle()
                                .stroke(
                                    isSelected ? Color.green.opacity(0.6) : Color.white.opacity(0.3),
                                    lineWidth: isSelected ? 2 : 1
                                )
                        )
                    
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(isSelected ? .green : .white)
                        .shadow(color: isSelected ? .green.opacity(0.8) : .clear, radius: 5)
                }
                
                // Device Info
                VStack(alignment: .leading, spacing: 6) {
                    Text(name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Signal Strength & Selection
                VStack(spacing: 10) {
                    if !isTestDevice {
                        SignalStrengthView(strength: signalStrength)
                    }
                    
                    ZStack {
                        if isSelected {
                            Circle()
                                .fill(Color.green.opacity(0.2))
                                .frame(width: 28, height: 28)
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.title2)
                                .shadow(color: .green.opacity(0.8), radius: 5)
                        } else {
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: [.white.opacity(0.5), .white.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .background(.ultraThinMaterial)
                        .overlay(Color.black.opacity(0.3))
                        .environment(\.colorScheme, .dark)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: isSelected ?
                                [.green.opacity(0.6), .mint.opacity(0.4)] :
                                [.white.opacity(0.3), .white.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: isSelected ? 2 : 1
                        )
                }
            )
            .shadow(
                color: isSelected ? .green.opacity(0.3) : .black.opacity(0.2),
                radius: isSelected ? 15 : 8,
                x: 0,
                y: isSelected ? 8 : 4
            )
            .scaleEffect(isSelected ? 1.02 : 1.0)
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SignalStrengthView: View {
    let strength: Int
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<4) { index in
                RoundedRectangle(cornerRadius: 1)
                    .fill(
                        index < strength ?
                        LinearGradient(colors: [.green, .mint], startPoint: .top, endPoint: .bottom) :
                        LinearGradient(colors: [.white.opacity(0.3), .white.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: 3, height: CGFloat(4 + index * 2))
                    .shadow(color: index < strength ? .green.opacity(0.5) : .clear, radius: 2)
            }
        }
    }
}

struct NoDevicesFoundCard: View {
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 28))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Text("No devices found")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("Make sure your device is powered on and in pairing mode")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial.opacity(0.3))
                    .environment(\.colorScheme, .dark)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        style: StrokeStyle(lineWidth: 1, dash: [8, 4])
                    )
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white.opacity(0.4), .white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
        )
    }
}

struct ConnectButton: View {
    let bluetoothManager: BluetoothManager
    let isTestDeviceSelected: Bool
    let selectedPeripheral: CBPeripheral?
    @Binding var isScanning: Bool
    
    var body: some View {
        Button(action: {
            if isTestDeviceSelected {
                bluetoothManager.connectToTestDevice()
            } else if let peripheral = selectedPeripheral {
                bluetoothManager.connect(to: peripheral)
            } else {
                withAnimation(.spring()) {
                    isScanning = true
                    bluetoothManager.startScanning()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isScanning = false
                    }
                }
            }
        }) {
            HStack(spacing: 12) {
                if bluetoothManager.connectionStatus == "Connecting..." {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.9)
                } else {
                    Image(systemName: buttonIcon)
                        .font(.title3)
                        .shadow(color: .white.opacity(0.5), radius: 3)
                }
                
                Text(buttonText)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                colors: buttonGradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.3), .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1
                        )
                }
            )
            .shadow(color: buttonShadowColor, radius: 15, x: 0, y: 8)
        }
        .disabled(bluetoothManager.connectionStatus == "Connecting...")
        .scaleEffect(bluetoothManager.connectionStatus == "Connecting..." ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: bluetoothManager.connectionStatus)
    }
    
    private var buttonText: String {
        switch bluetoothManager.connectionStatus {
        case "Connecting...":
            return "Connecting..."
        case "Connected":
            return "Connected"
        default:
            if isTestDeviceSelected || selectedPeripheral != nil {
                return "Connect Device"
            } else {
                return "Refresh Devices"
            }
        }
    }
    
    private var buttonIcon: String {
        switch bluetoothManager.connectionStatus {
        case "Connected":
            return "checkmark.circle.fill"
        default:
            if isTestDeviceSelected || selectedPeripheral != nil {
                return "bolt.fill"
            } else {
                return "arrow.clockwise"
            }
        }
    }
    
    private var buttonGradient: [Color] {
        switch bluetoothManager.connectionStatus {
        case "Connected":
            return [.green.opacity(0.8), .mint.opacity(0.6)]
        case "Connecting...":
            return [.orange.opacity(0.8), .yellow.opacity(0.6)]
        default:
            return [.green.opacity(0.8), .mint.opacity(0.6)]
        }
    }
    
    private var buttonShadowColor: Color {
        switch bluetoothManager.connectionStatus {
        case "Connected":
            return .green.opacity(0.4)
        case "Connecting...":
            return .orange.opacity(0.4)
        default:
            return .green.opacity(0.4)
        }
    }
}

// Reuse ParticleEffectView from welcome page
struct DeviceParticleEffectView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<6, id: \.self) { index in
                Circle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: CGFloat.random(in: 3...6))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: animate ? CGFloat.random(in: 0...UIScreen.main.bounds.height) : UIScreen.main.bounds.height + 50
                    )
                    .animation(
                        .linear(duration: Double.random(in: 10...20))
                        .repeatForever(autoreverses: false)
                        .delay(Double.random(in: 0...8)),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    NavigationStack {
        DeviceSelectionView()
    }
}

