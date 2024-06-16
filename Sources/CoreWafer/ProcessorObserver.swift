//
//  ProcessorObserver.swift
//  
//
//  Created by MacBook Pro on 2021/12/04.
//

import Foundation
import Combine
import ProcessorKit

public class ProcessorObserver: ObservableObject {
    @Published public var overallUsage: ProcessorUsage
    @Published public var coreUsages: [ProcessorUsage]
    
    private var cancellable: AnyCancellable?
    
    public init() {
        overallUsage = CPU.systemUsage()
        coreUsages = CPU.coreUsage()
    }
    
    func update() {
        print("⚙️ Updated")
        overallUsage = CPU.systemUsage()
        coreUsages = CPU.coreUsage()
    }
    
    public func start(interval: Double = 5.0) {
        print("⚙️ Start")
        cancellable = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                self.update()
            })
    }
    
    public func cancel() {
        print("⚙️ Stop")
        cancellable?.cancel()
    }
}
