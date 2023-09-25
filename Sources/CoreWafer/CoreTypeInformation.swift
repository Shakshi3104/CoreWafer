//
//  CoreTypeInformation.swift
//  
//
//  Created by MacBook Pro on 2021/12/04.
//
import DeviceHardware

#if os(macOS)
typealias XDeviceHardware = MacDeviceHardware
#elseif os(iOS)
typealias XDeviceHardware = UIDeviceHardware
#endif

// MARK: - Obtain core type information
public struct CoreTypeInformation {
    private let deviceHardware: XDeviceHardware
    public let coreTypes: [WaferCoreTypes]
    
    public init() {
        #if os(macOS)
        deviceHardware = MacDeviceHardware.deviceHardware
        #elseif os(iOS)
        deviceHardware = UIDeviceHardware.deviceHardware
        #endif
        
        let processorName = deviceHardware.processorName
        
        print("\(deviceHardware.processorCount)-core \(processorName)")
        
        if let chip = AppleSilicon(rawValue: processorName) {
            let efficiencyCores: Int
            let performanceCores: Int
            
            switch chip {
            // MARK: - A Series
            case .A11:
                efficiencyCores = 4
                performanceCores = 2
            case .A12:
                efficiencyCores = 4
                performanceCores = 2
            case .A12X, .A12Z:
                efficiencyCores = 4
                performanceCores = 4
            case .A13:
                efficiencyCores = 4
                performanceCores = 2
            case .A14:
                efficiencyCores = 4
                performanceCores = 2
            case .A15:
                efficiencyCores = 4
                performanceCores = 2
            case .A16:
                efficiencyCores = 4
                performanceCores = 2
            case .A17Pro:
                efficiencyCores = 4
                performanceCores = 2
                
            // MARK: - M Series
            case .M1:
                efficiencyCores = 4
                performanceCores = 4
            case .M1Pro:
                efficiencyCores = 2
                performanceCores = deviceHardware.processorCount - efficiencyCores
            case .M1Max:
                efficiencyCores = 2
                performanceCores = 8
            case .M1Ultra:
                efficiencyCores = 4
                performanceCores = 16
            case .M2:
                efficiencyCores = 4
                performanceCores = 4
            case .M2Pro:
                efficiencyCores = 4
                performanceCores = deviceHardware.processorCount - efficiencyCores
            case .M2Max:
                efficiencyCores = 4
                performanceCores = 8
            case .M2Ultra:
                efficiencyCores = 8
                performanceCores = 16
            default:
                // Not big.LITTLE
                efficiencyCores = 0
                performanceCores = 0
            }
            
            if efficiencyCores == 0 && performanceCores == 0 {
                // Not big.LITTLE
                coreTypes = Array(repeating: WaferCoreTypes.plain, count: deviceHardware.processorCount)
            } else {
                // big.LITTLE
                coreTypes = Array(repeating: WaferCoreTypes.efficiency, count: efficiencyCores) + Array(repeating: WaferCoreTypes.performance, count: performanceCores)
            }
        } else {
            coreTypes = Array(repeating: WaferCoreTypes.plain, count: deviceHardware.processorCount)
        }
    }
}
