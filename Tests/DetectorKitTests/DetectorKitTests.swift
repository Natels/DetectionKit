import Testing

@testable import DetectorKit

@Test func testIsJailbroken() async throws {
    #expect(await Detector.isJailbroken() == false)
}
