// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit

let notableFiles = [
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

let notableSymbols = [
    "MSHookFunction",
    "MSHookMessageEx",
    "MSFindSymbol",
    "MSGetImageByName",
    "ZzBuildHook",
    "DobbyHook",
    "LHHookFunctions",
]

let notableDylds = [
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

let notableUrls = [
    "cydia://",
    "sileo://",
    "zbra://",
    "filza://",
    "activator://",
]

public struct Detector {
    public static func detectNotableFiles() -> [String] {
        var files = [String]()

        for file in notableFiles {
            if FileManager.default.fileExists(atPath: file) {
                files.append(file)
            }
        }

        return files
    }

    public static func detectNotableSymbols() -> [String] {
        var symbols = [String]()

        for symbol in notableSymbols {
            if dlsym(dlopen(nil, RTLD_NOW), symbol) != nil {
                symbols.append(symbol)
            }
        }

        return symbols
    }

    public static func detectNotableDylds() -> [String] {
        var dylds = [String]()

        for dyld in notableDylds {
            if dlopen(dyld, RTLD_NOW) != nil {
                dylds.append(dyld)
            }
        }

        return dylds
    }

    @MainActor
    public static func detectNotableUrls() -> [String] {
        var urls = [String]()

        for url in notableUrls {
            if UIApplication.shared.canOpenURL(URL(string: url)!) {
                urls.append(url)
            }
        }

        return urls
    }

    @MainActor
    public static func notableCharacteristicsDetected() -> Bool {
        let files = detectNotableFiles()
        let symbols = detectNotableSymbols()
        let dylds = detectNotableDylds()
        let urls = detectNotableUrls()

        return !files.isEmpty || !symbols.isEmpty || !dylds.isEmpty || !urls.isEmpty
    }
}
