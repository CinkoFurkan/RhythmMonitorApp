//
//  welcome_page.swift
//  RhythmMonitorApp
//
//  Created by Furkan Cinko on 13.06.2025.
//

import SwiftUI

struct welcome_page: View {
    @State private var animateTitle = false
    @State private var animateSubtitle = false
    @State private var animateButton = false
    @State private var pulseAnimation = false
    @State private var backgroundScale: CGFloat = 1.0
    
    var body: some View {
        NavigationView {
            ZStack {
                // Animated background
                Image("welcome_page_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea()
                    .scaleEffect(backgroundScale)
                    .animation(.easeInOut(duration: 20).repeatForever(autoreverses: true), value: backgroundScale)
                
                // Dynamic gradient overlay
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.black.opacity(0.7), location: 0.0),
                        .init(color: Color.black.opacity(0.3), location: 0.4),
                        .init(color: Color.black.opacity(0.8), location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // Animated particles effect
                ParticleEffectView()
                
                VStack(spacing: 32) {
                    Spacer(minLength: 80)
                    
                    // Animated heart icon with pulse effect
                    ZStack {
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [Color.green.opacity(0.3), Color.clear]),
                                    center: .center,
                                    startRadius: 10,
                                    endRadius: 80
                                )
                            )
                            .frame(width: 120, height: 120)
                            .scaleEffect(pulseAnimation ? 1.2 : 0.8)
                            .opacity(pulseAnimation ? 0.8 : 0.4)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulseAnimation)
                        
                        Image(systemName: "heart.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                            .shadow(color: .green, radius: 10)
                            .scaleEffect(pulseAnimation ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulseAnimation)
                    }
                    .offset(y: animateTitle ? 0 : -50)
                    .opacity(animateTitle ? 1 : 0)
                    
                    // Enhanced title with gradient text
                    VStack(spacing: 12) {
                        Text("Welcome to")
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                            .offset(y: animateTitle ? 0 : -30)
                            .opacity(animateTitle ? 1 : 0)
                        
                        Text("RhythmMonitor")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [.white, .green.opacity(0.8)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .multilineTextAlignment(.center)
                            .shadow(color: .green.opacity(0.6), radius: 15, x: 0, y: 8)
                            .offset(y: animateTitle ? 0 : -40)
                            .opacity(animateTitle ? 1 : 0)
                    }
                    .padding(.horizontal)
                    
                    // Enhanced subtitle with typewriter effect
                    VStack(spacing: 8) {
                        Text("Monitor your Heart Rate")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        Text("with Rhythm24")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [.green, .mint]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    }
                    .multilineTextAlignment(.center)
                    .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)
                    .offset(y: animateSubtitle ? 0 : 30)
                    .opacity(animateSubtitle ? 1 : 0)
                    
                    Spacer()
                    
                    // Feature highlights
                    HStack(spacing: 30) {
                        FeatureItem(icon: "waveform.path.ecg", text: "Real-time\nMonitoring")
                        FeatureItem(icon: "chart.line.uptrend.xyaxis", text: "Health\nAnalytics")
                        FeatureItem(icon: "bell.badge", text: "Smart\nAlerts")
                    }
                    .offset(y: animateSubtitle ? 0 : 40)
                    .opacity(animateSubtitle ? 1 : 0)
                    
                    // Enhanced button with glassmorphism effect
                    NavigationLink(
                        destination: DeviceSelectionView(),
                        label: {
                            HStack(spacing: 12) {
                                Image(systemName: "link.circle.fill")
                                    .font(.title3)
                                
                                Text("Connect Device")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Image(systemName: "arrow.right")
                                    .font(.title3)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(
                                ZStack {
                                    // Glassmorphism background
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .dark)
                                    
                                    // Gradient border
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.green.opacity(0.8), .mint.opacity(0.6)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 2
                                        )
                                    
                                    // Inner glow
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.green.opacity(0.2), .clear]),
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                }
                            )
                            .shadow(color: .green.opacity(0.4), radius: 15, x: 0, y: 8)
                            .scaleEffect(animateButton ? 1.0 : 0.8)
                            .opacity(animateButton ? 1 : 0)
                        }
                    )
                    .padding(.bottom, 50)
                }
                .padding(.horizontal, 20)
            }
            .navigationBarHidden(true)
            .onAppear {
                startAnimations()
            }
        }
    }
    
    private func startAnimations() {
        // Start background animation
        backgroundScale = 1.1
        
        // Stagger the animations for a smooth entrance
        withAnimation(.easeOut(duration: 1.0).delay(0.2)) {
            animateTitle = true
        }
        
        withAnimation(.easeOut(duration: 1.0).delay(0.6)) {
            animateSubtitle = true
        }
        
        withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(1.0)) {
            animateButton = true
        }
        
        // Start pulse animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            pulseAnimation = true
        }
    }
}

struct FeatureItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.green)
                .frame(width: 30, height: 30)
            
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
}

struct ParticleEffectView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<8, id: \.self) { index in
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: CGFloat.random(in: 4...8))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: animate ? CGFloat.random(in: 0...UIScreen.main.bounds.height) : UIScreen.main.bounds.height + 50
                    )
                    .animation(
                        .linear(duration: Double.random(in: 8...15))
                        .repeatForever(autoreverses: false)
                        .delay(Double.random(in: 0...5)),
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
    welcome_page()
}
