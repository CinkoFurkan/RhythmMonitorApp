# RhythmMonitor 📱❤️

A sophisticated iOS heart rate monitoring application built with SwiftUI that connects to Bluetooth-enabled heart rate devices for real-time cardiovascular monitoring and data analysis.

![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0+-green.svg)
![Bluetooth](https://img.shields.io/badge/Bluetooth-BLE-lightblue.svg)

## 🌟 Overview

RhythmMonitor is a comprehensive heart rate monitoring solution designed for fitness enthusiasts, healthcare professionals, and researchers. The app seamlessly integrates with Rhythm24 devices and other Bluetooth Low Energy heart rate monitors to provide real-time cardiovascular data with beautiful, animated visualizations.

## ✨ Key Features

### 🔄 Real-Time Monitoring
- **Live Heart Rate Display**: Large, easy-to-read BPM counter with animated heart icon
- **Dynamic Visualizations**: Pulsing animations synchronized with heart rate
- **Heart Rate Zones**: Automatic categorization (Rest, Active, Aerobic, Peak)
- **Status Indicators**: Real-time health status with color-coded feedback

### 📊 Data Collection & Analysis
- **60-Second Data Collection**: Systematic heart rate data gathering every second
- **CSV Export**: Professional data export for research and analysis
- **Statistical Analysis**: Average, minimum, and maximum heart rate calculations
- **Share Functionality**: Easy data sharing via iOS share sheet

### 🔗 Bluetooth Connectivity
- **Device Scanning**: Automatic detection of nearby BLE heart rate monitors
- **Signal Strength Indicators**: Visual representation of connection quality
- **Test Device Mode**: Built-in simulation for development and demonstration
- **Connection Management**: Robust connection handling with status updates

### 📈 Analytics & History
- **Historical Data**: Comprehensive session history with timestamps
- **Weekly Summaries**: Aggregated statistics and trends
- **Visual Analytics**: Charts and graphs (ready for implementation)
- **Session Tracking**: Duration and performance metrics

### 🎨 Modern UI/UX
- **Glassmorphism Design**: Modern, translucent interface elements
- **Dynamic Backgrounds**: Color schemes that adapt to heart rate zones
- **Particle Effects**: Subtle animations for enhanced user experience
- **Responsive Design**: Optimized for all iPhone screen sizes

## 🛠 Technical Architecture

### Core Technologies
- **SwiftUI**: Modern declarative UI framework
- **Core Bluetooth**: BLE device communication
- **Combine**: Reactive programming for data flow
- **CoreGraphics**: Custom animations and visual effects

### App Structure
```
RhythmMonitorApp/
├── Views/
│   ├── welcome_page.swift          # Animated welcome screen
│   ├── DeviceSelectionView.swift   # Bluetooth device connection
│   ├── ContentView.swift           # Main tab container
│   ├── LiveMonitorView.swift       # Real-time monitoring
│   ├── DataCollectionView.swift    # Data gathering interface
│   ├── AnalyticsView.swift         # Statistics and trends
│   ├── HistoryView.swift           # Historical data
│   └── ProfileView.swift           # User settings
├── Managers/
│   └── BluetoothManager.swift      # BLE communication
├── Models/
│   └── HeartbeatData.swift         # Data structures
└── ViewModels/
    └── HeartbeatViewModel.swift    # Business logic
```

## 🚀 Installation & Setup

### Prerequisites
- Xcode 14.0+
- iOS 15.0+ target device
- Bluetooth-enabled heart rate monitor (optional - test mode available)

### Build Instructions
1. **Clone the repository**
   ```bash
   git clone [repository-url]
   cd RhythmMonitorApp
   ```

2. **Open in Xcode**
   ```bash
   open RhythmMonitorApp.xcodeproj
   ```

3. **Configure Bluetooth Permissions**
   - Ensure `NSBluetoothAlwaysUsageDescription` is set in Info.plist
   - Add privacy usage descriptions for Bluetooth access

4. **Build and Run**
   - Select target device or simulator
   - Build and run the project (⌘+R)

## 📱 Usage Guide

### Getting Started
1. **Launch the App**: Start with the animated welcome screen
2. **Connect Device**: Choose "Connect Device" to access Bluetooth scanning
3. **Select Monitor**: Choose your heart rate device or use "Test Device"
4. **Start Monitoring**: Access real-time heart rate data

### Data Collection
1. **Navigate to Collect Tab**: Tap the "Collect" tab in the main interface
2. **Start Collection**: Press "Start Collection" for 60-second data gathering
3. **Monitor Progress**: Watch the circular progress indicator
4. **Export Data**: Share collected data as CSV file

### Monitoring Features
- **Live View**: Real-time BPM with animated visualizations
- **Zone Detection**: Automatic heart rate zone classification
- **Session Tracking**: Monitor workout duration and averages
- **History**: Review past sessions and trends

## 🎯 Heart Rate Zones

| Zone | BPM Range | Color | Description |
|------|-----------|-------|-------------|
| Rest | 0-60 | Blue | Resting heart rate |
| Active | 60-100 | Green | Normal active range |
| Aerobic | 100-140 | Yellow | Aerobic exercise zone |
| Peak | 140+ | Red | High-intensity zone |

## 📸 Screenshots

*[Add your app screenshots here]*

### Welcome Screen
*[Screenshot of animated welcome page]*

### Device Connection
*[Screenshot of Bluetooth device selection]*

### Live Monitoring
*[Screenshot of real-time heart rate display]*

### Data Collection
*[Screenshot of data collection interface]*

### Analytics Dashboard
*[Screenshot of analytics and history views]*

## 🔧 Key Features Implemented

### Advanced SwiftUI Techniques
- ✅ Custom animations and transitions
- ✅ Dynamic gradient backgrounds
- ✅ Glassmorphism design patterns
- ✅ Complex layout compositions
- ✅ State management with `@StateObject` and `@ObservedObject`

### Bluetooth Low Energy Integration
- ✅ CBCentralManager implementation
- ✅ Device scanning and discovery
- ✅ Connection management
- ✅ Error handling and status updates

### Data Management
- ✅ CSV file generation and export
- ✅ Real-time data collection
- ✅ Historical data persistence
- ✅ Statistical calculations

### User Experience
- ✅ Responsive design patterns
- ✅ Accessibility considerations
- ✅ Intuitive navigation flow
- ✅ Professional visual feedback

## 🚀 Future Enhancements

### Planned Features
- [ ] **HealthKit Integration**: Sync with Apple Health
- [ ] **Cloud Sync**: iCloud data synchronization
- [ ] **Workout Integration**: Apple Watch compatibility
- [ ] **Advanced Analytics**: Machine learning insights
- [ ] **Social Features**: Sharing and challenges
- [ ] **Alerts System**: Custom heart rate alerts

### Technical Improvements
- [ ] **Core Data**: Local database implementation
- [ ] **Network Layer**: API integration for cloud features
- [ ] **Testing Suite**: Unit and UI test coverage
- [ ] **Accessibility**: Enhanced VoiceOver support

## 🎓 Skills Demonstrated

This project showcases proficiency in:

- **iOS Development**: SwiftUI, UIKit integration, iOS frameworks
- **Bluetooth Technology**: Core Bluetooth, BLE communication protocols
- **Data Visualization**: Custom charts, animations, real-time updates
- **Architecture Patterns**: MVVM, separation of concerns, clean code
- **User Experience**: Modern design patterns, accessibility, responsive layouts
- **Data Management**: File I/O, CSV handling, data persistence

## 👨‍💻 Developer

**Furkan Cinko**
- Email: [your-email@example.com]
- LinkedIn: [your-linkedin-profile]
- GitHub: [your-github-profile]

## 📄 License

This project is developed for educational and portfolio purposes.

---

*Built with ❤️ and SwiftUI*
