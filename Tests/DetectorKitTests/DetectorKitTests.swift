import Testing

@testable import DetectionKit

@Suite("Detect environment tests")
struct DetectorKitTests {
    @Test("can detect notable characteristics")
    func testDetector() async throws {
        #expect(Detector.scan().detected == true)
    }
}
