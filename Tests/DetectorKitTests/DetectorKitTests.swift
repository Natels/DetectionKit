import Testing

@testable import DetectorKit

@Test func testDetector() async throws {
    #expect(await Detector.notableCharacteristicsDetected() == true)
}
