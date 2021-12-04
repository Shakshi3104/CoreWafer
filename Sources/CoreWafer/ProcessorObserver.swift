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
    @Published var overallUsage: ProcessorUsage
    @Published var coreUsages: [ProcessorUsage]
    
    private var cancellable: AnyCancellable?
    
    init() {
        overallUsage = CPU.systemUsage()
        coreUsages = CPU.coreUsage()
    }
    
    func update() {
        print("⚙️ Updated")
        overallUsage = CPU.systemUsage()
        coreUsages = CPU.coreUsage()
    }
    
    func start(interval: Double = 5.0) {
        print("⚙️ Start")
        cancellable = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                self.update()
            })
    }
    
    func cancel() {
        print("⚙️ Stop")
        cancellable?.cancel()
    }
}
