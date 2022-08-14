//
//  File.swift
//  
//
//  Created by MacBook Pro on 2021/12/04.
//

// MARK: - Core type
public enum WaferCoreTypes: String {
    /// efficiency core
    case efficiency = "Efficiency"
    /// performance core
    case performance = "Performance"
    /// not efficency / performance core (all same type core)
    case plain = ""
}

// MARK: - Apple Silicon for iPhone, iPad, iPod touch and Mac
enum AppleSilicon: String {
    // A Series
    case A4 = "Apple A4"
    case A5 = "Apple A5"
    case A5X = "Apple A5X"
    case A6 = "Apple A6"
    case A6X = "Apple A6X"
    case A7 = "Apple A7"
    case A8 = "Apple A8"
    case A8X = "Apple A8X"
    case A9 = "Apple A9"
    case A9X = "Apple A9X"
    case A10 = "Apple A10 Fusion"
    case A10X = "Apple A10X Fusion"
    case A11 = "Apple A11 Bionic"
    case A12 = "Apple A12 Bionic"
    case A12X = "Apple A12X Bionic"
    case A12Z = "Apple A12Z Bionic"
    case A13 = "Apple A13 Bionic"
    case A14 = "Apple A14 Bionic"
    case A15 = "Apple A15 Bionic"
    
    // M Seris
    case M1 = "Apple M1"
    case M1Pro = "Apple M1 Pro"
    case M1Max = "Apple M1 Max"
    case M1Ultra = "Apple M1 Ultra"
    case M2 = "Apple M2"
}
