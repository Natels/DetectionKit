import Testing

@testable import DetectorKit

@Test func testDeviceDetector() async throws {
    print("Device.systemVersion: \(Device.systemVersion)")
    #expect(Device.systemVersion.contains("Version"))
}
