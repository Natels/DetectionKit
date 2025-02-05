import Testing

@testable import DetectorKit

@Suite("Device info tests")
struct DeviceTests {
    @Test("can detect os name")
    func testDetectOSName() async throws {
        print(await Device.osName)
        #expect(await Device.osName != "-")
    }

    @Test("can detect system version")
    func testDetectSystemVersion() async throws {
        print(await Device.osVersion)
        #expect(await Device.osVersion.contains("Version"))
    }

    @Test("can detect the device model")
    func testDetectDeviceModel() async throws {
        print(await Device.deviceModel)
        #expect(await Device.deviceModel != "-")
    }
}
