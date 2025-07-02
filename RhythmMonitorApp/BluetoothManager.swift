//
//  BluetoothManager.swift
//  RhythmMonitorApp
//
//  Created by Furkan Cinko on 31.05.2025.
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var devices: [CBPeripheral] = []
    @Published var isConnected: Bool = false // ✅ Added this property
    @Published var connectionStatus: String = "Disconnected" // Optional: for status updates
    
    private var centralManager: CBCentralManager?
    private var connectedPeripheral: CBPeripheral?

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startScanning() {
        devices.removeAll()
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
        print("Scanning for peripherals...")
    }

    func stopScanning() {
        centralManager?.stopScan()
        print("Stopped scanning for peripherals.")
    }

    func connect(to peripheral: CBPeripheral) {
        stopScanning()
        connectionStatus = "Connecting..."
        centralManager?.connect(peripheral, options: nil)
        connectedPeripheral = peripheral
    }
    
    // ✅ New function to handle test device connection
    func connectToTestDevice() {
        stopScanning()
        connectionStatus = "Connected to Test Device"
        isConnected = true
        print("Connected to Test Device")
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth is powered on")
            startScanning()
        case .poweredOff:
            print("Bluetooth is powered off")
            connectionStatus = "Bluetooth is off"
        case .unauthorized:
            print("Bluetooth usage is unauthorized")
            connectionStatus = "Bluetooth unauthorized"
        case .unsupported:
            print("Bluetooth not supported on this device")
            connectionStatus = "Bluetooth not supported"
        default:
            print("Bluetooth is in unknown or resetting state")
            connectionStatus = "Bluetooth unavailable"
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !devices.contains(where: { $0.identifier == peripheral.identifier }) {
            if let name = peripheral.name, !name.isEmpty {
                devices.append(peripheral)
                print("Discovered peripheral: \(name)")
            }
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to peripheral: \(peripheral.name ?? "Unknown")")
        connectedPeripheral = peripheral
        connectionStatus = "Connected to \(peripheral.name ?? "Unknown")"
        isConnected = true // ✅ Set to true when connected
        
        // Set up the peripheral delegate to discover services
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from peripheral: \(peripheral.name ?? "Unknown")")
        isConnected = false // ✅ Set to false when disconnected
        connectionStatus = "Disconnected"
        connectedPeripheral = nil
        startScanning()
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to peripheral: \(peripheral.name ?? "Unknown")")
        isConnected = false // ✅ Set to false on connection failure
        connectionStatus = "Connection failed"
    }
    
    // ✅ Disconnect function
    func disconnect() {
        if let peripheral = connectedPeripheral {
            centralManager?.cancelPeripheralConnection(peripheral)
        }
        isConnected = false
        connectionStatus = "Disconnected"
        connectedPeripheral = nil
    }
    
    // MARK: - CBPeripheralDelegate methods (for future use)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("Error discovering services: \(error.localizedDescription)")
            return
        }
        
        // Handle discovered services here
        print("Discovered services for \(peripheral.name ?? "Unknown")")
    }
}
