import Foundation
#if canImport(UIKit)
import UIKit
#endif

@MainActor
struct Device {
    static let osVersion: String = ProcessInfo.processInfo.operatingSystemVersionString
    static var osName: String {
        #if os(macOS)
        return "macOS"
        #elseif os(watchOS)
        return "watchOS"
        #elseif canImport(UIKit)
        return UIDevice.current.systemName
        #else
        return "-"
        #endif
    }
    static var deviceModel: String {
        #if os(macOS)
        return sysctlString(name: "hw.model") ?? "-"
        #elseif os(watchOS)
        return sysctlString(name: "hw.model") ?? "-"
        #elseif canImport(UIKit)
        return UIDevice.current.model
        #else
        return "-"
        #endif
    }
}

extension Device {
    // Function to get the value of a sysctl parameter
    static func sysctlbyname<T>(name: String, type: T.Type) -> T? {
        var size: Int = 0
        Darwin.sysctlbyname(name, nil, &size, nil, 0)
        let value = UnsafeMutableRawPointer.allocate(
            byteCount: size,
            alignment: MemoryLayout<T>.alignment
        )
        defer { value.deallocate() }
        if Darwin.sysctlbyname(name, value, &size, nil, 0) == 0 {
            return value.load(as: T.self)
        }
        return nil
    }

    // Function to get a string value from sysctl
    static func sysctlString(name: String) -> String? {
        var size: Int = 0
        Darwin.sysctlbyname(name, nil, &size, nil, 0)
        var value = [CChar](repeating: 0, count: size)
        if Darwin.sysctlbyname(name, &value, &size, nil, 0) == 0 {
            return String(utf8String: value)
        }
        return nil
    }

}
