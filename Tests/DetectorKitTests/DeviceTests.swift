import Testing

@testable import DetectorKit

@Suite("Device info tests")
struct DeviceTests {
    @Test("can detect os name")
    func testDetectOSName() async throws {
        #expect(await Device.osName != "-")
    }

    @Test("can detect system version")
    func testDetectSystemVersion() async throws {
        #expect(Device.systemVersion.contains("Version"))
    }
}
