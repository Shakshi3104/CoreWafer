//
//  CoreTypeInformation.swift
//  
//
//  Created by MacBook Pro on 2021/12/04.
//
import Foundation

import DeviceHardware

#if os(macOS)
typealias XDeviceHardware = MacDeviceHardware
#elseif os(iOS)
typealias XDeviceHardware = UIDeviceHardware
#endif

// MARK: -
private func obtainPerformanceCores() -> Int? {
    var cores: Int64 = 0
    var size = MemoryLayout<Int64>.size
    
    if sysctlbyname("hw.perflevel0.physicalcpu", &cores, &size, nil, 0) != 0 {
        return nil
    }
    
    return Int(cores)
}

private func obtainEfficiencyCores() -> Int? {
    var cores: Int64 = 0
    var size = MemoryLayout<Int64>.size
    
    if sysctlbyname("hw.perflevel1.physicalcpu", &cores, &size, nil, 0) != 0 {
        return nil
    }
    
    return Int(cores)
}

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
        
        if let efficiencyCores = obtainEfficiencyCores(),
           let performanceCores = obtainPerformanceCores() {
            
            if efficiencyCores + performanceCores == deviceHardware.processorCount {
                // big.LITTLE
                coreTypes = Array(repeating: WaferCoreTypes.efficiency, count: efficiencyCores)
                + Array(repeating: WaferCoreTypes.performance, count: performanceCores)
            } else {
                coreTypes = Array(repeating: WaferCoreTypes.plain, count: deviceHardware.processorCount)
            }
            
        } else {
            // Not big.LITTLE
            coreTypes = Array(repeating: WaferCoreTypes.plain, count: deviceHardware.processorCount)
        }
    }
}
