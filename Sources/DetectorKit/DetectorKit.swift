// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct Detector {
    public static let notableFiles = [
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
        "/Applications/RockApp.app",
        "/Applications/Icy.app",
        "/usr/sbin/sshd",
        "/usr/bin/sshd",
        "/usr/libexec/sftp-server",
        "/Applications/WinterBoard.app",
        "/Applications/SBSettings.app",
        "/Applications/MxTube.app",
        "/Applications/IntelliScreen.app",
        "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
        "/Applications/FakeCarrier.app",
        "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
        "/private/var/lib/apt",
        "/private/var/stash",
        "/private/var/mobile/Library/SBSettings/Themes",
        "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
        "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
        "/private/var/tmp/cydia.log",
        "/private/var/lib/cydia",
        "/Applications/blackra1n.app",
        "/Library/MobileSubstrate/MobileSubstrate.dylib",
        "/var/cache/apt/",
        "/var/lib/apt/",
        "/var/log/syslog",
        "/etc/apt",
        "/usr/lib/libcycript.dylib",
        "/System/Library/LaunchDaemons/com.saurik.substrated.plist",
    ]

    public static let notableSymbols = [
        "MSHookFunction",
        "MSHookMessageEx",
        "MSFindSymbol",
        "MSGetImageByName",
        "ZzBuildHook",
        "DobbyHook",
        "LHHookFunctions",
        "MSHookMemory",
        "MSHookIvar",
        "ZzReplace",
        "cycriptNotify",
        "_ZL8sub_Initialize",
    ]

    public static let notableDylds = [
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
        "Electra",
        "rocketbootstrap",
        "libcycript",
        "SubstrateDynLoader",
        "yalu",
        "mach_portal",
        "topanga",
        "electra",
        "unc0ver",
        "checkra1n",
        "odyssey",
        "libjailbreak",
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
    public static func notableCharacteristicsDetected() -> Bool {
        let files = detectFiles(matching: notableFiles)
        let symbols = detectSymbols(matching: notableSymbols)
        let dylds = detectDylds(matching: notableDylds)

        return !files.isEmpty || !symbols.isEmpty || !dylds.isEmpty
    }
}
