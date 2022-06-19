//
//  WaftersView.swift
//  
//
//  Created by MacBook Pro on 2021/12/04.
//

import SwiftUI
import ProcessorKit

public struct WafersView: View {
    @ObservedObject var processor: ProcessorObserver
    private let coreType = CoreTypeInformation()
    
    public init(processor: ProcessorObserver) {
        self.processor = processor
    }
    
    public var body: some View {
        if processor.coreUsages.count < 30 {
            HStack(alignment: .bottom) {
                EachCoreView(coreUsages: processor.coreUsages, coreTypes: coreType.coreTypes)
            }
            .padding(20)
        } else {
            // For Macs with a large number of cores, such as the MacPro, use 2 lines
            VStack {
                let halfCoreCount: Int = processor.coreUsages.count / 2
                
                EachCoreView(coreUsages: Array(processor.coreUsages[0..<halfCoreCount]),
                             coreTypes: Array(coreType.coreTypes[0..<halfCoreCount]))
                
                EachCoreView(coreUsages: Array(processor.coreUsages[halfCoreCount..<processor.coreUsages.count]),
                             coreTypes: Array(coreType.coreTypes[halfCoreCount..<processor.coreUsages.count]))
            }
        }
    }
}

// MARK: - Each core usage bar
public struct EachCoreView: View {
    var coreUsages: [ProcessorUsage]
    var coreTypes: [WaferCoreTypes]
    
    public var body: some View {
        HStack(alignment: .bottom) {
            ForEach(0..<coreUsages.count, id: \.self) { num in
                // Color of performance core is purple
                let color = coreTypes[num] == .performance
                ? Color.iris
                : Color.peacockGreen
                
                let coreUsage = coreUsages[num]
                let totalUsage = min(99.9, round((coreUsage.user + coreUsage.system) * 10.0) / 10.0)
                
                BarView(value: totalUsage * 1.2, color: color)
            }
        }
    }
}

// MARK: - Bar
public struct BarView: View {
    var value: CGFloat
    var maxValue: CGFloat = 120
    var color = Color(.sRGB, red: 0.2, green: 0.5, blue: 0.8)
    
    public var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: maxValue)
                    .foregroundColor(.secondary.opacity(0.2))
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: value)
                    .foregroundColor(color)
            }
        }
    }
}

// MARK: - Color extension
public extension Color {
    static let iris = Color(.sRGB, red: 0.6, green: 0.5, blue: 0.8)
    static let peacockGreen = Color(.sRGB, red: 0.2, green: 0.6, blue: 0.7)
}

// MARK: - Preview
struct WafersView_Previews: PreviewProvider {
    static var previews: some View {
        WafersView(processor: ProcessorObserver())
    }
}
