// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

#if canImport(UIKit)
    import UIKit
#endif

let jailbreakFiles = [
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

let jailbreakSymbols = [
    "MSHookFunction",
    "MSHookMessageEx",
    "MSFindSymbol",
    "MSGetImageByName",
    "ZzBuildHook",
    "DobbyHook",
    "LHHookFunctions",
]

let jailbreakDylds = [
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

let jailbreakURLs = [
    "cydia://",
    "sileo://",
    "zbra://",
    "filza://",
    "activator://",
]

public struct Detector {
    public static func detectJailbreakFiles() -> [String] {
        var files = [String]()

        for file in jailbreakFiles {
            if FileManager.default.fileExists(atPath: file) {
                files.append(file)
            }
        }

        return files
    }

    public static func detectJailbreakSymbols() -> [String] {
        var symbols = [String]()

        for symbol in jailbreakSymbols {
            if dlsym(dlopen(nil, RTLD_NOW), symbol) != nil {
                symbols.append(symbol)
            }
        }

        return symbols
    }

    public static func detectJailbreakDylds() -> [String] {
        var dylds = [String]()

        for dyld in jailbreakDylds {
            if dlopen(dyld, RTLD_NOW) != nil {
                dylds.append(dyld)
            }
        }

        return dylds
    }

    @MainActor
    public static func detectJailbreakURLs() -> [String] {
        var urls = [String]()

        #if canImport(UIKit)
            for url in jailbreakURLs {
                if UIApplication.shared.canOpenURL(URL(string: url)!) {
                    urls.append(url)
                }
            }
        #endif

        return urls
    }

    @MainActor
    public static func isJailbroken() -> Bool {
        let files = detectJailbreakFiles()
        let symbols = detectJailbreakSymbols()
        let dylds = detectJailbreakDylds()
        let urls = detectJailbreakURLs()

        return !files.isEmpty || !symbols.isEmpty || !dylds.isEmpty || !urls.isEmpty
    }
}
