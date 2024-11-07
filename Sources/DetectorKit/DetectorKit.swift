// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit

public struct Detector {
    static let notableFiles = [
        "/Applications/Cydia.app",
        "/Applications/Sileo.app",
        "/var/binpack",
        "/Library/MobileSubstrate/DynamicLibraries",
        "/Library/PreferenceBundles/LibertyPref.bundle",
        "/Library/PreferenceBundles/ShadowPreferences.bundle",
        "/Library/PreferenceBundles/ABypassPrefs.bundle",
        "/Library/PreferenceBundles/FlyJBPrefs.bundle",
        "/usr/lib/libhooker.dylib",
        "/usr/lib/libsubstitute.dylib",
        "/usr/lib/substrate",
        "/usr/lib/TweakInject",
    ]

    static let notableSymbols = [
        "MSHookFunction",
        "MSHookMessageEx",
        "MSFindSymbol",
        "MSGetImageByName",
        "ZzBuildHook",
        "DobbyHook",
        "LHHookFunctions",
    ]

    static let notableDylds = [
        "MobileSubstrate",
        "TweakInject",
        "libhooker",
        "substrate",
        "SubstrateLoader",
        "SubstrateInserter",
        "SubstrateBootstrap",
        "substrate",
        "ABypass",
        "FlyJB",
        "substitute",
        "Cephei",
        "rocketbootstrap",
        "Electra",
    ]

    static let notableUrls = [
        "cydia://",
        "sileo://",
        "zbra://",
        "filza://",
        "activator://",
    ]

    public static func detectFiles(matching names: [String]) -> [String] {
        var files = [String]()

        for file in names {
            if FileManager.default.fileExists(atPath: file) {
                files.append(file)
            }
        }

        return files
    }

    public static func detectSymbols(matching names: [String]) -> [String] {
        var symbols = [String]()

        for symbol in names {
            if dlsym(dlopen(nil, RTLD_NOW), symbol) != nil {
                symbols.append(symbol)
            }
        }

        return symbols
    }

    public static func detectDylds(matching names: [String]) -> [String] {
        var dylds = [String]()

        for dyld in names {
            if dlopen(dyld, RTLD_NOW) != nil {
                dylds.append(dyld)
            }
        }

        return dylds
    }

    @MainActor
    public static func detectUrlHandlers(matching urls: [String]) -> [String] {
        var urls = [String]()

        for url in urls {
            if UIApplication.shared.canOpenURL(URL(string: url)!) {
                urls.append(url)
            }
        }

        return urls
    }

    @MainActor
    public static func notableCharacteristicsDetected() -> Bool {
        let files = detectFiles(matching: notableFiles)
        let symbols = detectSymbols(matching: notableSymbols)
        let dylds = detectDylds(matching: notableDylds)
        let urls = detectUrlHandlers(matching: notableUrls)

        return !files.isEmpty || !symbols.isEmpty || !dylds.isEmpty || !urls.isEmpty
    }
}
