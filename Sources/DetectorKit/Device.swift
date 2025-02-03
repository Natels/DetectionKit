import Foundation
#if canImport(UIKit)
import UIKit
#endif

struct Device {
    static let systemVersion: String = ProcessInfo.processInfo.operatingSystemVersionString
    @MainActor
    static var osName: String {
        #if os(macOS)
            return "macOS"
        #elseif canImport(UIKit)
            return UIDevice.current.systemName
        #else
            return "-"
        #endif
    }
}
