import Testing

@testable import DetectorKit

@Suite("Detect environment tests")
struct DetectorKitTests {
    @Test("can detect notable characteristics")
    func testDetector() async throws {
        #expect(Detector.notableCharacteristicsDetected() == true)
    }
}
