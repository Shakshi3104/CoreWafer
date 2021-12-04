import XCTest
@testable import CoreWafer

final class CoreWaferTests: XCTestCase {
    
    func testCoreCountDeviceHardware() throws {
        XCTAssertEqual(CoreTypeInformation().coreTypes.count, XDeviceHardware.deviceHardware.processorCount)
    }
    
    func testCoreCountProcessorKit() throws {
        XCTAssertEqual(CoreTypeInformation().coreTypes.count, ProcessorObserver().coreUsages.count)
    }
}
